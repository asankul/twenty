#!/usr/bin/env python3
"""Снимает названия полей и видов с живой базы и собирает 09_labels.sql.

Запуск:
    PSQL='ssh -i ~/.ssh/twenty-deploy root@HOST docker exec -i twenty-db-1 psql -U postgres -d default' \
        ./extract_labels.py

Это то, чего не хватало больше всего, и чего я не заметил дважды.
В Квартале переведены не только свои поля, но и сотни стандартных полей
Twenty — «Название» вместо Name, «Адрес» вместо Address, «Кем создана»
вместо Created by. Их переводили руками по ходу месяца работы, и без
этого шага новый кабинет остаётся наполовину английским, даже когда
объекты уже называются по-русски.

Переносим названия ВСЕХ полей, а не только отличающихся: так файл можно
прогонять повторно, и он просто приводит кабинет к эталону.

isLabelSyncedWithName выключается у каждого поля — иначе Twenty
перезапишет название обратно из технического имени.
"""
import os
import subprocess
import sys

SEP = "\x1f"


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

    fields = psql("""
        select o."nameSingular", f.name, f.label, coalesce(f.description,'')
          from core."fieldMetadata" f
          join core."objectMetadata" o on o.id = f."objectMetadataId"
         order by 1, 2;""")

    views = psql("""
        select o."nameSingular", v.key::text, v.name
          from core.view v
          join core."objectMetadata" o on o.id = v."objectMetadataId"
         where v."deletedAt" is null and v.key is not null
         order by 1, 2;""")

    out = ["""-- Названия полей и видов.
--
-- Снято с живой базы Квартала скриптом extract_labels.py.
-- Имя схемы кабинета подставляет install.sh вместо __WS__.
--
-- В Квартале переведены не только свои поля, но и сотни стандартных полей
-- Twenty: «Название» вместо Name, «Адрес» вместо Address, «Кем создана»
-- вместо Created by. Без этого шага кабинет остаётся наполовину
-- английским, даже когда объекты уже называются по-русски.
--
-- Переносим названия всех полей, а не только отличающихся: так файл
-- просто приводит кабинет к эталону и его можно прогонять повторно.
--
-- isLabelSyncedWithName выключается: иначе Twenty перезапишет название
-- обратно из технического имени поля.
""", "-- ── Названия полей ───────────────────────────────────────────────"]

    for obj, name, label, descr in fields:
        out.append(f"""update core."fieldMetadata" f
   set label = {lit(label)},
       description = {lit(descr)},
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
 where f."objectMetadataId" = o.id
   and f.name = {lit(name)}
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from {lit(label)};""")

    out.append("\n-- ── Названия видов ───────────────────────────────────────────────")
    for obj, key, name in views:
        out.append(f"""update core.view v
   set name = {lit(name)}, "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
 where v."objectMetadataId" = o.id
   and v.key::text = {lit(key)}
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from {lit(name)};""")

    path = os.path.join(here, "09_labels.sql")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(out) + "\n")

    print(f"09_labels.sql: полей {len(fields)}, видов {len(views)}")


if __name__ == "__main__":
    main()
