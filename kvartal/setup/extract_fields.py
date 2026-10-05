#!/usr/bin/env python3
"""Снимает наши поля с живой базы и собирает 01_fields.sql.

Запуск:
    PSQL='ssh -i ~/.ssh/twenty-deploy root@HOST docker exec -i twenty-db-1 psql -U postgres -d default' \
        ./extract_fields.py workspace_d23hh7a34snje4p8trbenc2ot

Почему генератор, а не написанный руками SQL: полей 42, у составных типов
на каждое приходится по нескольку колонок (CURRENCY это две, PHONES четыре),
плюс перечисления со своими значениями. Руками это не собрать без ошибок,
а живая база знает точно.

Наши поля отличаются от стандартных принадлежностью к кастомному приложению
кабинета: workspace."workspaceCustomApplicationId". Признак переносится между
базами, потому что ищется по смыслу, а не по идентификатору.
"""
import json
import os
import subprocess
import sys

OBJECTS = ("opportunity", "task", "person", "workspaceMember")
SEP = "\x1f"


def psql(sql):
    """Запрос уходит в stdin: по дороге к боевой базе стоит ещё один шелл,
    и он разорвал бы многострочный SQL на словах."""
    cmd = os.environ.get("PSQL", "psql").split() + ["-At", "-F", SEP]
    out = subprocess.run(cmd, input=sql, capture_output=True, text=True)
    if out.returncode != 0:
        sys.exit(f"Запрос не прошёл:\n{out.stderr}")
    rows = []
    for line in out.stdout.split("\n"):
        if line.strip("\x1f \t") == "" and SEP not in line:
            continue
        rows.append(line.split(SEP))
    return rows


def lit(value):
    """Строковый литерал SQL; None превращается в NULL."""
    if value is None or value == "":
        return "null"
    return "'" + str(value).replace("'", "''") + "'"


def main():
    if len(sys.argv) < 2:
        sys.exit("Укажите схему: ./extract_fields.py workspace_xxxxxxxx")
    ws = sys.argv[1]
    here = os.path.dirname(os.path.abspath(__file__))

    objects_in = ", ".join(lit(o) for o in OBJECTS)

    # ── Поля ───────────────────────────────────────────────────────────
    fields = psql(f"""
        select o."nameSingular", f.name, f.type::text, f.label,
               coalesce(f.icon, ''), coalesce(f.description, ''),
               f."isNullable"::text, f."isUIReadOnly"::text, f."isUIEditable"::text,
               f."isSystem"::text, f."isLabelSyncedWithName"::text,
               f."isSystemSideEffect"::text, f."isAuditLogged"::text,
               f.writability::text,
               coalesce(f.options::text, ''), coalesce(f.settings::text, ''),
               coalesce(f."defaultValue"::text, '')
          from core."fieldMetadata" f
          join core."objectMetadata" o on o.id = f."objectMetadataId"
          join core.workspace w on w."workspaceCustomApplicationId" = f."applicationId"
         where o."nameSingular" in ({objects_in})
           and f.type not in ('RELATION', 'MORPH_RELATION')
         order by 1, 2;""")

    # ── Колонки под эти поля ───────────────────────────────────────────
    # Составное поле раскладывается в несколько колонок, имя которых
    # начинается с имени поля и продолжается с заглавной буквы.
    columns = psql(f"""
        with ours as (
          select o."nameSingular" as obj, f.name as fld
            from core."fieldMetadata" f
            join core."objectMetadata" o on o.id = f."objectMetadataId"
            join core.workspace w on w."workspaceCustomApplicationId" = f."applicationId"
           where o."nameSingular" in ({objects_in})
             and f.type not in ('RELATION', 'MORPH_RELATION')
        )
        select distinct ours.obj, c.column_name,
               format_type(a.atttypid, a.atttypmod)
          from ours
          join information_schema.columns c
            on c.table_schema = {lit(ws)} and c.table_name = ours.obj
           and (c.column_name = ours.fld or c.column_name ~ ('^' || ours.fld || '[A-Z]'))
          join pg_attribute a
            on a.attrelid = (quote_ident(c.table_schema)||'.'||quote_ident(c.table_name))::regclass
           and a.attname = c.column_name
         order by 1, 2;""")

    # ── Перечисления, на которые эти колонки ссылаются ─────────────────
    enums = psql(f"""
        select t.typname,
               (select string_agg(quote_literal(e.enumlabel), ', ' order by e.enumsortorder)
                  from pg_enum e where e.enumtypid = t.oid)
          from pg_type t
          join pg_namespace n on n.oid = t.typnamespace
         where n.nspname = {lit(ws)} and t.typtype = 'e'
         order by 1;""")

    used = {c[2] for c in columns}
    needed = [e for e in enums if any(e[0] in u for u in used)]

    out = [
        "-- Наши поля на заявке, задаче, контакте и сотруднике.",
        "--",
        "-- Собрано скриптом extract_fields.py с живой базы Квартала.",
        "-- Имя схемы кабинета подставляет install.sh вместо __WS__.",
        "--",
        "-- Поля ищутся по принадлежности к кастомному приложению кабинета,",
        "-- а не по списку имён: так ничего не потеряется при добавлении новых.",
        "-- В новой базе приложение находится тем же способом, по смыслу.",
        "",
        "-- ── Перечисления ─────────────────────────────────────────────────",
    ]

    for name, labels in needed:
        out.append(f"""do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = '{name}') then
    create type __WS__.{json.dumps(name)[1:-1] if False else '"' + name + '"'} as enum ({labels});
  end if;
end $enum$;""")

    out += ["", "-- ── Колонки ──────────────────────────────────────────────────────"]
    for obj, col, typ in columns:
        typ_ws = typ.replace(ws + ".", "__WS__.")
        out.append(f'alter table __WS__."{obj}" add column if not exists "{col}" {typ_ws};')

    out += ["", "-- ── Метаданные полей ─────────────────────────────────────────────"]
    for (obj, name, ftype, label, icon, descr, nullable, readonly, editable,
         system, synced, side_effect, audited, writability, options, settings,
         default_value) in fields:
        out.append(f"""insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, {lit(ftype)}, {lit(name)}, {lit(label)},
       {lit(descr)}, {lit(icon)},
       {('null' if not options else lit(options) + '::jsonb')},
       {('null' if not settings else lit(settings) + '::jsonb')},
       {('null' if not default_value else lit(default_value) + '::jsonb')},
       true, {system}, {readonly}, {editable}, {nullable},
       {synced}, {side_effect}, {audited}, {lit(writability)},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = {lit(name)});""")

    path = os.path.join(here, "01_fields.sql")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(out) + "\n")

    if ws in open(path, encoding="utf-8").read():
        sys.exit("ОШИБКА: имя боевой схемы осталось в файле")

    print(f"01_fields.sql: перечислений {len(needed)}, колонок {len(columns)}, полей {len(fields)}")


if __name__ == "__main__":
    main()
