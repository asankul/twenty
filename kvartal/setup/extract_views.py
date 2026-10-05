#!/usr/bin/env python3
"""Снимает виды с живой базы и собирает 05_views.sql.

Запуск:
    PSQL='ssh -i ~/.ssh/twenty-deploy root@HOST docker exec -i twenty-db-1 psql -U postgres -d default' \
        ./extract_views.py

Переносим только то, что описывает устройство работы, а не конкретных
людей. Одиннадцать досок в Квартале названы именами брокеров — им в
другом кабинете делать нечего, поэтому список видов задан явно.

Колонки вида привязываются к полям по имени. Поля, которых в кабинете
нет, просто пропускаются: вставка не находит поле и ничего не делает.
Благодаря этому файл можно прогнать до того, как поля устоялись, и
повторить после — лишнего не появится, недостающее доедет.
"""
import os
import subprocess
import sys

SEP = "\x1f"

# Виды, которые переносим. Остальные либо про конкретных брокеров
# (доски с именами), либо про недвижимость («Застройщики и ЖК»).
WANTED = {
    "opportunity": ["Воронка", "Все лиды", "Мои лиды", "Без ответственного",
                    "Opportunity Record Page Fields"],
    "task": ["All Задачи", "Assigned to Me", "By Status",
             "Task Record Page Fields"],
}


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


def num(v):
    return v if v not in (None, "") else "null"


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    names = ", ".join(lit(n) for objs in WANTED.values() for n in objs)

    views = psql(f"""
        select om."nameSingular", v.name, v.type::text, coalesce(v.icon,''),
               coalesce(v.key::text,''), coalesce(v.position::text,''),
               v."isCompact"::text, v."isCustom"::text,
               coalesce(v."openRecordIn"::text,''),
               coalesce(v."kanbanAggregateOperation"::text,''),
               coalesce(kf.name,''), coalesce(gf.name,''),
               coalesce(v."shouldHideEmptyGroups"::text,''),
               coalesce(v.visibility::text,''), coalesce(v."anyFieldFilterValue",'')
          from core.view v
          join core."objectMetadata" om on om.id = v."objectMetadataId"
          left join core."fieldMetadata" kf on kf.id = v."kanbanAggregateOperationFieldMetadataId"
          left join core."fieldMetadata" gf on gf.id = v."mainGroupByFieldMetadataId"
         where v."deletedAt" is null and v.name in ({names})
         order by 1, 2;""")

    out = ["""-- Виды: воронка, списки, карточка заявки.
--
-- Собрано скриптом extract_views.py с живой базы Квартала.
-- Имя схемы кабинета подставляет install.sh вместо __WS__.
--
-- Переносим только устройство работы. Одиннадцать досок в Квартале
-- названы именами брокеров — в другом кабинете им делать нечего,
-- поэтому список видов в генераторе задан явно.
--
-- Колонки привязываются к полям по имени. Поля, которого в кабинете нет,
-- вставка не найдёт и просто пропустит — файл можно прогонять повторно
-- после того, как состав полей изменится.
"""]

    out.append("-- ── Виды ─────────────────────────────────────────────────────────")
    for (obj, name, vtype, icon, key, position, compact, custom, open_in,
         kanban_op, kanban_field, group_field, hide_empty, visibility, anyfilter) in views:
        kf_join = (f"""
  left join core."fieldMetadata" kf on kf."objectMetadataId" = o.id and kf.name = {lit(kanban_field)}"""
                   if kanban_field else "")
        gf_join = (f"""
  left join core."fieldMetadata" gf on gf."objectMetadataId" = o.id and gf.name = {lit(group_field)}"""
                   if group_field else "")
        out.append(f"""insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), {lit(name)}, o.id, {lit(vtype)}, {lit(icon)}, {lit(key)},
       {num(position)}, {compact}, {custom}, {lit(open_in)}, {lit(kanban_op)},
       {'kf.id' if kanban_field else 'null'}, {'gf.id' if group_field else 'null'},
       {hide_empty if hide_empty else 'null'}, {lit(visibility)}, {lit(anyfilter)},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}{kf_join}{gf_join}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = {lit(name)}
                      and v."deletedAt" is null);""")

    # ── Колонки видов ──────────────────────────────────────────────────
    fields = psql(f"""
        select om."nameSingular", v.name, f.name, vf."isVisible"::text,
               coalesce(vf.size::text,''), coalesce(vf.position::text,''),
               coalesce(vf."aggregateOperation"::text,'')
          from core."viewField" vf
          join core.view v on v.id = vf."viewId"
          join core."objectMetadata" om on om.id = v."objectMetadataId"
          join core."fieldMetadata" f on f.id = vf."fieldMetadataId"
         where vf."deletedAt" is null and v."deletedAt" is null and v.name in ({names})
         order by 1, 2, 6;""")

    out.append("\n-- ── Колонки видов ────────────────────────────────────────────────")
    for obj, view, fld, visible, size, position, agg in fields:
        out.append(f"""insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, {visible}, {num(size)}, {num(position)},
       {lit(agg)}, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
  join core.view v on v."objectMetadataId" = o.id and v.name = {lit(view)} and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = {lit(fld)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);""")

    # ── Сортировки ─────────────────────────────────────────────────────
    sorts = psql(f"""
        select om."nameSingular", v.name, f.name, vs.direction::text
          from core."viewSort" vs
          join core.view v on v.id = vs."viewId"
          join core."objectMetadata" om on om.id = v."objectMetadataId"
          join core."fieldMetadata" f on f.id = vs."fieldMetadataId"
         where vs."deletedAt" is null and v."deletedAt" is null and v.name in ({names})
         order by 1, 2, 3;""")

    out.append("\n-- ── Сортировки ───────────────────────────────────────────────────")
    for obj, view, fld, direction in sorts:
        out.append(f"""insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, {lit(direction)},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
  join core.view v on v."objectMetadataId" = o.id and v.name = {lit(view)} and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = {lit(fld)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);""")

    # ── Фильтры ────────────────────────────────────────────────────────
    # Фильтр «Мои лиды» сравнивает владельца с текущим пользователем —
    # значение внутри не ссылается на конкретного человека, поэтому
    # переносится как есть.
    filters = psql(f"""
        select om."nameSingular", v.name, f.name, vfl.operand::text,
               coalesce(vfl.value::text,''), coalesce(vfl."subFieldName",'')
          from core."viewFilter" vfl
          join core.view v on v.id = vfl."viewId"
          join core."objectMetadata" om on om.id = v."objectMetadataId"
          join core."fieldMetadata" f on f.id = vfl."fieldMetadataId"
         where vfl."deletedAt" is null and v."deletedAt" is null and v.name in ({names})
         order by 1, 2, 3;""")

    out.append("\n-- ── Фильтры ──────────────────────────────────────────────────────")
    for obj, view, fld, operand, value, subfield in filters:
        out.append(f"""insert into core."viewFilter"
  (id, "viewId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, {lit(operand)}, {lit(value)}, {lit(subfield)},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
  join core.view v on v."objectMetadataId" = o.id and v.name = {lit(view)} and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = {lit(fld)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewFilter" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);""")

    path = os.path.join(here, "05_views.sql")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(out) + "\n")

    print(f"05_views.sql: видов {len(views)}, колонок {len(fields)}, "
          f"сортировок {len(sorts)}, фильтров {len(filters)}")


if __name__ == "__main__":
    main()
