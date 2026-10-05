#!/usr/bin/env python3
"""Снимает роли и права с живой базы и собирает 04_roles.sql.

Запуск:
    PSQL='ssh -i ~/.ssh/twenty-deploy root@HOST docker exec -i twenty-db-1 psql -U postgres -d default' \
        ./extract_roles.py

Прав четыре слоя, и они ссылаются друг на друга идентификаторами:
роль → права по объектам → права по полям → построчные правила,
причём правила сгруппированы и указывают на поле сотрудника, с которым
сравнивают запись. В другой базе все идентификаторы другие, поэтому
генератор нигде их не переносит: всё ищется по именам — роль по названию,
объект по nameSingular, поле по паре «объект + имя».

Стандартные роли Admin и Member в новом кабинете уже есть, их не трогаем:
создаём только свои и навешиваем права на все, включая стандартные.
"""
import os
import subprocess
import sys

SEP = "\x1f"
STANDARD_ROLES = ("Admin",)


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
    out = ["""-- Роли и права кабинета.
--
-- Собрано скриптом extract_roles.py с живой базы Квартала.
-- Имя схемы кабинета подставляет install.sh вместо __WS__.
--
-- Идентификаторы нигде не переносятся: в другой базе они другие. Всё
-- ищется по именам — роль по названию, объект по nameSingular, поле по
-- паре «объект + имя». Поэтому файл можно ставить на любой кабинет.
--
-- Повторный прогон безопасен: каждая вставка проверяет, нет ли уже такой
-- записи.
"""]

    # ── Роли ───────────────────────────────────────────────────────────
    roles = psql("""
        select r.label, coalesce(r.description,''), coalesce(r.icon,''),
               r."canReadAllObjectRecords"::text, r."canUpdateAllObjectRecords"::text,
               r."canSoftDeleteAllObjectRecords"::text, r."canDestroyAllObjectRecords"::text,
               r."canUpdateAllSettings"::text, r."canAccessAllTools"::text,
               r."isEditable"::text, r."canBeAssignedToUsers"::text,
               r."canBeAssignedToAgents"::text, r."canBeAssignedToApiKeys"::text
          from core.role r
         where r."isEditable" = true
         order by r.label;""")

    out.append("-- ── Роли ─────────────────────────────────────────────────────────")
    for (label, descr, icon, read_all, upd_all, soft_all, destroy_all,
         settings, tools, editable, to_users, to_agents, to_keys) in roles:
        out.append(f"""insert into core.role
  (id, label, description, icon, "canReadAllObjectRecords", "canUpdateAllObjectRecords",
   "canSoftDeleteAllObjectRecords", "canDestroyAllObjectRecords", "canUpdateAllSettings",
   "canAccessAllTools", "isEditable", "canBeAssignedToUsers", "canBeAssignedToAgents",
   "canBeAssignedToApiKeys", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), {lit(label)}, {lit(descr)}, {lit(icon)},
       {read_all}, {upd_all}, {soft_all}, {destroy_all}, {settings}, {tools},
       {editable}, {to_users}, {to_agents}, {to_keys},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.role r
                    where r."workspaceId" = w.id and r.label = {lit(label)});""")

    # ── Права по объектам ──────────────────────────────────────────────
    objperms = psql("""
        select r.label, o."nameSingular",
               op."canReadObjectRecords"::text, op."canUpdateObjectRecords"::text,
               op."canSoftDeleteObjectRecords"::text, op."canDestroyObjectRecords"::text
          from core."objectPermission" op
          join core.role r on r.id = op."roleId"
          join core."objectMetadata" o on o.id = op."objectMetadataId"
         order by 1, 2;""")

    out.append("\n-- ── Права по объектам ────────────────────────────────────────────")
    for role, obj, can_read, can_upd, can_soft, can_destroy in objperms:
        out.append(f"""insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, {can_read}, {can_upd}, {can_soft}, {can_destroy},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = {lit(role)}
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);""")

    # ── Права по полям ─────────────────────────────────────────────────
    fieldperms = psql("""
        select r.label, o."nameSingular", f.name,
               fp."canReadFieldValue"::text, fp."canUpdateFieldValue"::text
          from core."fieldPermission" fp
          join core.role r on r.id = fp."roleId"
          join core."fieldMetadata" f on f.id = fp."fieldMetadataId"
          join core."objectMetadata" o on o.id = fp."objectMetadataId"
         order by 1, 2, 3;""")

    out.append("\n-- ── Права по полям ───────────────────────────────────────────────")
    for role, obj, fld, can_read, can_upd in fieldperms:
        out.append(f"""insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, {can_read}, {can_upd},
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = {lit(role)}
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = {lit(fld)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);""")

    # ── Построчные правила ─────────────────────────────────────────────
    # Группа одна на пару «роль + объект», поэтому её можно найти обратно
    # по этой же паре, не перенося идентификатор.
    groups = psql("""
        select r.label, o."nameSingular", g."logicalOperator"::text,
               coalesce(g."positionInRowLevelPermissionPredicateGroup"::text, '')
          from core."rowLevelPermissionPredicateGroup" g
          join core.role r on r.id = g."roleId"
          join core."objectMetadata" o on o.id = g."objectMetadataId"
         where g."deletedAt" is null and g."parentRowLevelPermissionPredicateGroupId" is null
         order by 1, 2;""")

    out.append("\n-- ── Построчные правила: группы ───────────────────────────────────")
    for role, obj, op, pos in groups:
        out.append(f"""insert into core."rowLevelPermissionPredicateGroup"
  (id, "roleId", "objectMetadataId", "logicalOperator",
   "positionInRowLevelPermissionPredicateGroup", "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, {lit(op)},
       {pos if pos else 'null'}, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = {lit(role)}
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicateGroup" g
                    where g."roleId" = r.id and g."objectMetadataId" = o.id
                      and g."deletedAt" is null);""")

    preds = psql("""
        select r.label, o."nameSingular", f.name, p.operand::text,
               coalesce(p.value::text, ''), coalesce(p."subFieldName", ''),
               coalesce(wf.name, ''), coalesce(p."workspaceMemberSubFieldName", ''),
               coalesce(p."positionInRowLevelPermissionPredicateGroup"::text, '')
          from core."rowLevelPermissionPredicate" p
          join core.role r on r.id = p."roleId"
          join core."objectMetadata" o on o.id = p."objectMetadataId"
          left join core."fieldMetadata" f on f.id = p."fieldMetadataId"
          left join core."fieldMetadata" wf on wf.id = p."workspaceMemberFieldMetadataId"
         where p."deletedAt" is null
         order by 1, 2, 3, 4;""")

    out.append("\n-- ── Построчные правила: условия ──────────────────────────────────")
    for (role, obj, fld, operand, value, subfield, wm_field, wm_subfield, pos) in preds:
        wm_join = (f"""
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = {lit(wm_field)}"""
                   if wm_field else "")
        wm_value = "wmf.id" if wm_field else "null"
        out.append(f"""insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       {lit(operand)},
       {lit(value) + '::jsonb' if value else 'null'}, {lit(subfield)},
       {wm_value}, {lit(wm_subfield)},
       g.id, {pos if pos else 'null'}, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = {lit(role)}
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = {lit(obj)}
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = {lit(fld)}
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null{wm_join}
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = {lit(operand)}
                      and p."deletedAt" is null);""")

    path = os.path.join(here, "04_roles.sql")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(out) + "\n")

    print(f"04_roles.sql: ролей {len(roles)}, прав по объектам {len(objperms)}, "
          f"по полям {len(fieldperms)}, групп {len(groups)}, условий {len(preds)}")


if __name__ == "__main__":
    main()
