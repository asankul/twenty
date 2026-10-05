#!/usr/bin/env python3
"""Снимает внешний вид кабинета: названия объектов и боковое меню.

Запуск:
    PSQL='ssh -i ~/.ssh/twenty-deploy root@HOST docker exec -i twenty-db-1 psql -U postgres -d default' \
        ./extract_look.py

Это то, что видно в первую очередь и чего не хватало больше всего:
без этих двух шагов кабинет выглядит как голый Twenty на английском,
даже когда внутри уже стоят поля, роли и флоу.

Собирает два файла:
    06_objects.sql — названия и значки объектов
    07_menu.sql    — свои пункты меню со ссылками
"""
import os
import subprocess
import sys

SEP = "\x1f"

# Объекты, названия которых мы меняли. Остальные оставляем как есть.
OBJECTS = ("opportunity", "person", "company", "task", "note", "workspaceMember")


def psql(sql):
    cmd = os.environ.get("PSQL", "psql").split() + ["-At", "-F", SEP, "-v", "ON_ERROR_STOP=1"]
    out = subprocess.run(cmd, input=sql, capture_output=True, text=True)
    if out.returncode != 0:
        sys.exit(f"Запрос не прошёл:\n{out.stderr}")
    return [l.split(SEP) for l in out.stdout.split("\n") if l.strip("\x1f \t")]


def lit(v):
    if v is None or v == "":
        return "null"
    return "'" + str(v).replace("'", "''") + "'"


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    names = ", ".join(lit(o) for o in OBJECTS)

    # ── Названия объектов ──────────────────────────────────────────────
    objs = psql(f"""
        select "nameSingular", "labelSingular", "labelPlural",
               coalesce(icon,''), coalesce(description,''),
               "isLabelSyncedWithName"::text
          from core."objectMetadata"
         where "nameSingular" in ({names})
         order by 1;""")

    out = ["""-- Названия и значки объектов.
--
-- Снято с живой базы Квартала скриптом extract_look.py.
-- Имя схемы кабинета подставляет install.sh вместо __WS__.
--
-- Без этого шага кабинет выглядит голым Twenty на английском: Opportunities
-- вместо Лидов, People вместо Клиентов — даже когда поля, роли и флоу
-- уже на месте.
--
-- isLabelSyncedWithName выключается: иначе Twenty перезапишет название
-- обратно из технического имени объекта.
""", "-- ── Названия ─────────────────────────────────────────────────────"]

    for name, label_s, label_p, icon, descr, synced in objs:
        out.append(f"""update core."objectMetadata" o
   set "labelSingular" = {lit(label_s)},
       "labelPlural" = {lit(label_p)},
       icon = {lit(icon)},
       description = {lit(descr)},
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = {lit(name)};""")

    with open(os.path.join(here, "06_objects.sql"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(out) + "\n")

    # ── Меню ───────────────────────────────────────────────────────────
    # Берём только свои пункты-ссылки. Пункты типа OBJECT Twenty заводит
    # сам при создании кабинета, а RECORD — это личные закладки людей,
    # переносить их в другой кабинет бессмысленно.
    menu = psql("""
        select name, type::text, link, position::text,
               coalesce(icon,''), coalesce(color,'')
          from core."navigationMenuItem"
         where type::text = 'LINK' and link is not null
           and "userWorkspaceId" is null
         order by position;""")

    out = ["""-- Свои пункты бокового меню.
--
-- Снято с живой базы Квартала скриптом extract_look.py.
--
-- Переносим только ссылки на наши страницы. Пункты типа OBJECT Twenty
-- заводит сам при создании кабинета, а RECORD — это личные закладки
-- конкретных людей, в другом кабинете им делать нечего.
""", "-- ── Пункты меню ──────────────────────────────────────────────────"]

    for name, mtype, link, position, icon, color in menu:
        out.append(f"""insert into core."navigationMenuItem"
  (id, name, type, link, position, icon, color, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), {lit(name)}, {lit(mtype)}, {lit(link)}, {position},
       {lit(icon)}, {lit(color)}, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."navigationMenuItem" n
                    where n."workspaceId" = w.id and n.link = {lit(link)});""")

    with open(os.path.join(here, "07_menu.sql"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(out) + "\n")

    print(f"06_objects.sql: объектов {len(objs)}")
    print(f"07_menu.sql: пунктов меню {len(menu)}")
    for name, _, link, *_ in menu:
        print(f"    {name} -> {link}")


if __name__ == "__main__":
    main()
