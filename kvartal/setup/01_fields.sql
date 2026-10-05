-- Наши поля на заявке, задаче, контакте и сотруднике.
--
-- Собрано скриптом extract_fields.py с живой базы Квартала.
-- Имя схемы кабинета подставляет install.sh вместо __WS__.
--
-- Поля ищутся по принадлежности к кастомному приложению кабинета,
-- а не по списку имён: так ничего не потеряется при добавлении новых.
-- В новой базе приложение находится тем же способом, по смыслу.

-- ── Перечисления ─────────────────────────────────────────────────
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_channel_enum') then
    create type __WS__."opportunity_channel_enum" as enum ('PHONE', 'INSTAGRAM', 'WHATSAPP', 'TELEGRAM', 'EMAIL');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_hasChat_enum') then
    create type __WS__."opportunity_hasChat_enum" as enum ('YES', 'NO');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_leadSource_enum') then
    create type __WS__."opportunity_leadSource_enum" as enum ('SRC_1', 'SRC_2', 'SRC_3', 'SRC_4', 'SRC_5', 'SRC_6', 'SRC_7', 'SRC_8', 'SRC_9', 'SRC_10', 'SRC_11');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_team_enum') then
    create type __WS__."opportunity_team_enum" as enum ('TEAM_1', 'TEAM_2', 'TEAM_3', 'TEAM_4');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_touchStatus_enum') then
    create type __WS__."opportunity_touchStatus_enum" as enum ('ON_TIME', 'WAITING', 'LATE');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'person_horizon_enum') then
    create type __WS__."person_horizon_enum" as enum ('NOW', 'QUARTER', 'HALF_YEAR', 'YEAR', 'LATER');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'person_payment_enum') then
    create type __WS__."person_payment_enum" as enum ('INSTALLMENT', 'CASH', 'MORTGAGE');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'person_purpose_enum') then
    create type __WS__."person_purpose_enum" as enum ('PERSONAL', 'INVESTMENT');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'task_kind_enum') then
    create type __WS__."task_kind_enum" as enum ('FIRST_TOUCH', 'FOLLOWUP', 'SHOWING', 'CONTRACT', 'PAYMENT', 'MANUAL');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'task_outcome_enum') then
    create type __WS__."task_outcome_enum" as enum ('NO_ANSWER', 'THINKING', 'SHOWING_SET', 'NO_SHOW', 'BOOKED', 'REFUSED', 'POSTPONED', 'NOT_OURS', 'RESCHEDULED', 'CONTRACT_SIGNED', 'DELAYED', 'PAID', 'COMPLETED', 'DROPPED');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'task_slaStatus_enum') then
    create type __WS__."task_slaStatus_enum" as enum ('ON_TIME', 'WARNING', 'LATE');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'task_team_enum') then
    create type __WS__."task_team_enum" as enum ('TEAM_1', 'TEAM_2', 'TEAM_3', 'TEAM_4');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'workspaceMember_seniority_enum') then
    create type __WS__."workspaceMember_seniority_enum" as enum ('SENIOR', 'BROKER');
  end if;
end $enum$;
do $enum$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'workspaceMember_team_enum') then
    create type __WS__."workspaceMember_team_enum" as enum ('TEAM_1', 'TEAM_2', 'TEAM_3', 'TEAM_4');
  end if;
end $enum$;

-- ── Колонки ──────────────────────────────────────────────────────
alter table __WS__."opportunity" add column if not exists "budgetMaxAmountMicros" numeric;
alter table __WS__."opportunity" add column if not exists "budgetMaxCurrencyCode" text;
alter table __WS__."opportunity" add column if not exists "channel" __WS__.opportunity_channel_enum;
alter table __WS__."opportunity" add column if not exists "chatContactId" double precision;
alter table __WS__."opportunity" add column if not exists "chatConversationId" double precision;
alter table __WS__."opportunity" add column if not exists "chatLinkPrimaryLinkLabel" text;
alter table __WS__."opportunity" add column if not exists "chatLinkPrimaryLinkUrl" text;
alter table __WS__."opportunity" add column if not exists "chatLinkSecondaryLinks" jsonb;
alter table __WS__."opportunity" add column if not exists "comment" text;
alter table __WS__."opportunity" add column if not exists "contactValue" text;
alter table __WS__."opportunity" add column if not exists "district" text;
alter table __WS__."opportunity" add column if not exists "hasChat" __WS__."opportunity_hasChat_enum";
alter table __WS__."opportunity" add column if not exists "lastMessage" text;
alter table __WS__."opportunity" add column if not exists "leadSource" __WS__."opportunity_leadSource_enum";
alter table __WS__."opportunity" add column if not exists "lostReason" text;
alter table __WS__."opportunity" add column if not exists "managerName" text;
alter table __WS__."opportunity" add column if not exists "phoneAdditionalPhones" jsonb;
alter table __WS__."opportunity" add column if not exists "phonePrimaryPhoneCallingCode" text;
alter table __WS__."opportunity" add column if not exists "phonePrimaryPhoneCountryCode" text;
alter table __WS__."opportunity" add column if not exists "phonePrimaryPhoneNumber" text;
alter table __WS__."opportunity" add column if not exists "priority" integer;
alter table __WS__."opportunity" add column if not exists "rooms" double precision;
alter table __WS__."opportunity" add column if not exists "team" __WS__.opportunity_team_enum;
alter table __WS__."opportunity" add column if not exists "touchAge" text;
alter table __WS__."opportunity" add column if not exists "touchMinutes" double precision;
alter table __WS__."opportunity" add column if not exists "touchStatus" __WS__."opportunity_touchStatus_enum";
alter table __WS__."opportunity" add column if not exists "waitingSince" timestamp with time zone;
alter table __WS__."person" add column if not exists "budgetMaxAmountMicros" numeric;
alter table __WS__."person" add column if not exists "budgetMaxCurrencyCode" text;
alter table __WS__."person" add column if not exists "district" text;
alter table __WS__."person" add column if not exists "horizon" __WS__.person_horizon_enum;
alter table __WS__."person" add column if not exists "messenger" text;
alter table __WS__."person" add column if not exists "payment" __WS__.person_payment_enum;
alter table __WS__."person" add column if not exists "purpose" __WS__.person_purpose_enum;
alter table __WS__."person" add column if not exists "rooms" double precision;
alter table __WS__."task" add column if not exists "kind" __WS__.task_kind_enum;
alter table __WS__."task" add column if not exists "nextAt" timestamp with time zone;
alter table __WS__."task" add column if not exists "outcome" __WS__.task_outcome_enum;
alter table __WS__."task" add column if not exists "priority" double precision;
alter table __WS__."task" add column if not exists "scheduledAt" timestamp with time zone;
alter table __WS__."task" add column if not exists "slaDueAt" timestamp with time zone;
alter table __WS__."task" add column if not exists "slaMinutes" double precision;
alter table __WS__."task" add column if not exists "slaStatus" __WS__."task_slaStatus_enum";
alter table __WS__."task" add column if not exists "snoozeCount" double precision;
alter table __WS__."task" add column if not exists "team" __WS__.task_team_enum;
alter table __WS__."workspaceMember" add column if not exists "kulpunaiAgentId" double precision;
alter table __WS__."workspaceMember" add column if not exists "seniority" __WS__."workspaceMember_seniority_enum";
alter table __WS__."workspaceMember" add column if not exists "team" __WS__."workspaceMember_team_enum";
alter table __WS__."workspaceMember" add column if not exists "telegramChatId" text;

-- ── Метаданные полей ─────────────────────────────────────────────
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'CURRENCY', 'budgetMax', 'Бюджет до',
       'Верхняя граница', 'IconCoins',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'budgetMax');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'channel', 'Канал',
       'Откуда пришло обращение', 'IconMessage',
       '[{"id": "0d2972d8-8abb-43f7-8531-16a016ccc3ec", "color": "blue", "label": "Телефон", "value": "PHONE", "position": 0}, {"id": "0c137bb1-97e9-428c-b5df-3b9670116d27", "color": "pink", "label": "Инстаграм", "value": "INSTAGRAM", "position": 1}, {"id": "2082a922-53e1-4b9f-870f-c02ec256f1d8", "color": "green", "label": "Вотсап", "value": "WHATSAPP", "position": 2}, {"id": "01d6eda6-974e-48ef-9787-b673447454f3", "color": "sky", "label": "Телеграм", "value": "TELEGRAM", "position": 3}, {"id": "8137a841-954b-481c-90db-29f782a1244e", "color": "gray", "label": "Почта", "value": "EMAIL", "position": 4}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'channel');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'chatContactId', 'Номер контакта',
       'Идентификатор контакта в KulpunAI. Нужен, чтобы записать в чат ссылку на эту заявку.', 'IconHash',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'chatContactId');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'chatConversationId', 'Номер диалога',
       'Идентификатор диалога в KulpunAI. Заполняется автоматически, по нему идёт синхронизация назначения.', 'IconHash',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'chatConversationId');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'LINKS', 'chatLink', 'Переписка',
       'Диалог в мессенджере', 'IconMessageCircle',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'chatLink');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'comment', 'Примечание',
       null, 'IconNotes',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'comment');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'contactValue', 'Контакт в канале',
       'Ник или номер, как пришёл', 'IconAt',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'contactValue');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'district', 'Район',
       null, 'IconMap2',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'district');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'hasChat', 'Есть переписка',
       null, 'IconMessageCircle',
       '[{"id": "808d918c-b5f7-41f9-b48d-86e23b6576b4", "color": "green", "label": "Есть чат", "value": "YES", "position": 0}, {"id": "edec50c6-e729-42d2-b9fa-eb6d3f9c436f", "color": "red", "label": "Чата нет", "value": "NO", "position": 1}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'hasChat');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'lastMessage', 'Последнее сообщение',
       null, 'IconMessage2',
       null,
       null,
       null,
       true, false, true, false, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'lastMessage');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'leadSource', 'Источник',
       'Откуда узнали', 'IconAffiliate',
       '[{"id": "8e4d19f4-21f4-42b3-939a-39cd0f9470f3", "color": "blue", "label": "Instagram", "value": "SRC_1", "position": 0}, {"id": "ac49e2bd-05b4-4ca5-a1df-daf6d9f2991a", "color": "pink", "label": "Звонок", "value": "SRC_2", "position": 1}, {"id": "35e010e7-5cec-4fbc-bf6a-d47f381d2d4d", "color": "green", "label": "Сайт", "value": "SRC_3", "position": 2}, {"id": "13e62066-b497-415d-9648-ddbd1affc772", "color": "sky", "label": "Рекомендация", "value": "SRC_4", "position": 3}, {"id": "2fee7543-3271-4d97-bd2c-28de9ffd475d", "color": "purple", "label": "Наружная реклама", "value": "SRC_5", "position": 4}, {"id": "6bb9d13f-0ff9-4926-9fa7-71f4511df678", "color": "orange", "label": "Пришёл в офис", "value": "SRC_6", "position": 5}, {"id": "b0cf7fd7-d8d6-4d88-93b1-01f7fdb6effc", "color": "turquoise", "label": "2GIS", "value": "SRC_7", "position": 6}, {"id": "4639ae5d-892e-4118-9af3-6b1ab21b0aa7", "color": "yellow", "label": "Другое", "value": "SRC_8", "position": 7}, {"id": "2fe09c9e-b686-4a43-9423-a1dd27186230", "color": "red", "label": "WhatsApp", "value": "SRC_9", "position": 8}, {"id": "b42a7596-75c0-47a9-894b-d0f21f726aff", "color": "gray", "label": "Telegram", "value": "SRC_10", "position": 9}, {"id": "5abc7986-18d6-4c72-af9a-c8aca12aa922", "color": "blue", "label": "Instagram Direct", "value": "SRC_11", "position": 10}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'leadSource');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'lostReason', 'Причина потери',
       'Почему ушёл из воронки', 'IconArchive',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'lostReason');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'managerName', 'Ответственный в старой системе',
       'Менеджер из прежней системы', 'IconUserCheck',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'managerName');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'PHONES', 'phone', 'Телефон',
       null, 'IconPhone',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'phone');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'priority', 'Важность',
       null, 'IconFlame',
       null,
       null,
       null,
       true, false, true, false, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'priority');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'rooms', 'Комнат',
       '0 — студия', 'IconDoor',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'rooms');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'team', 'Команда',
       'Команда ответственного. Заполняется автоматически, менять вручную нельзя.', 'IconUsersGroup',
       '[{"id": "0dc97da5-4825-4940-9aba-f71984058ae7", "color": "blue", "label": "Керимбекова Айчурок", "value": "TEAM_1", "position": 0}, {"id": "fcbeb446-348f-4dc9-864d-6ac245e5cd94", "color": "green", "label": "Арстанбек кызы Таалайкан", "value": "TEAM_2", "position": 1}, {"id": "513bbf28-01a0-4b30-ba05-e39a1da2fae2", "color": "orange", "label": "Алканов Тилек", "value": "TEAM_3", "position": 2}, {"id": "c3182015-b751-4469-89c0-0612e0edd32b", "color": "purple", "label": "Бузурманкулов Дастан", "value": "TEAM_4", "position": 3}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'team');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'touchAge', 'Без ответа',
       null, 'IconHourglassHigh',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'touchAge');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'touchMinutes', 'Минут до касания',
       null, 'IconHourglass',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'touchMinutes');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'touchStatus', 'Первое касание',
       null, 'IconClockBolt',
       '[{"id": "9459c7a6-efea-49b0-be52-4a773acb6a83", "color": "green", "label": "В срок", "value": "ON_TIME", "position": 0}, {"id": "2348ab75-5bf4-41dd-a627-87cc1980111a", "color": "yellow", "label": "Ждёт", "value": "WAITING", "position": 1}, {"id": "dc272aef-06f2-44fe-889e-9737b6df6e21", "color": "red", "label": "Просрочено", "value": "LATE", "position": 2}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'touchStatus');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'DATE_TIME', 'waitingSince', 'Ждёт с',
       null, 'IconHourglassHigh',
       null,
       null,
       null,
       true, false, true, false, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'waitingSince');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'CURRENCY', 'budgetMax', 'Бюджет до',
       'Верхняя граница', 'IconCoins',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'budgetMax');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'district', 'Район',
       'Где хочет жить', 'IconMap',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'district');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'horizon', 'Срок покупки',
       'Когда планирует', 'IconCalendarTime',
       '[{"id": "7de3cfec-01ab-4d10-8f3d-f04f53fe160a", "color": "blue", "label": "Сейчас", "value": "NOW", "position": 0}, {"id": "cce3c194-b590-4b69-8d44-acf4067c3b5f", "color": "pink", "label": "В течение квартала", "value": "QUARTER", "position": 1}, {"id": "4820f0cf-34d1-4b38-b137-c78cfde7f648", "color": "green", "label": "Полгода", "value": "HALF_YEAR", "position": 2}, {"id": "7185d9c6-8348-4842-ba18-9e46d2bccfa1", "color": "sky", "label": "Год", "value": "YEAR", "position": 3}, {"id": "9fea50a5-08bc-45c8-9037-f224f3afe713", "color": "purple", "label": "Позже", "value": "LATER", "position": 4}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'horizon');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'messenger', 'Мессенджер',
       'Ник в переписке', 'IconBrandInstagram',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'messenger');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'payment', 'Форма оплаты',
       'Как платит', 'IconCreditCard',
       '[{"id": "15e0f528-3f70-42b6-8b04-1380d4671137", "color": "blue", "label": "Рассрочка", "value": "INSTALLMENT", "position": 0}, {"id": "55320e9a-db56-499e-956d-aac3a9494960", "color": "pink", "label": "Наличные", "value": "CASH", "position": 1}, {"id": "8b659c48-81a0-4fcc-8f7a-282eb2b6a6cc", "color": "green", "label": "Ипотека", "value": "MORTGAGE", "position": 2}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'payment');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'purpose', 'Цель покупки',
       'Для себя или вложение', 'IconTargetArrow',
       '[{"id": "c6fea53a-3e5a-4076-a19b-0d86f86a4ae8", "color": "blue", "label": "Для себя", "value": "PERSONAL", "position": 0}, {"id": "e2006b1c-57bd-477e-aa39-ca524820ed4d", "color": "pink", "label": "Инвестиция", "value": "INVESTMENT", "position": 1}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'purpose');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'rooms', 'Комнат',
       '0 — студия', 'IconDoor',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'rooms');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'kind', 'Вид задачи',
       null, 'IconRoute',
       '[{"id": "3aa3fbc1-1e60-443e-9318-dd7d99be0753", "color": "sky", "label": "Первое касание", "value": "FIRST_TOUCH", "position": 0}, {"id": "eabb16ce-2a52-48ac-a2bb-bf1e3415129b", "color": "orange", "label": "Повторный контакт", "value": "FOLLOWUP", "position": 1}, {"id": "8bd2970f-2ba5-4d25-86bd-3c0ffe88dfb3", "color": "blue", "label": "Показ", "value": "SHOWING", "position": 2}, {"id": "be9eaf8d-c632-4477-b137-a1329b1d71bd", "color": "yellow", "label": "Договор", "value": "CONTRACT", "position": 3}, {"id": "ce78aaa0-7749-49e6-aa80-a512754fcdc0", "color": "green", "label": "Оплата", "value": "PAYMENT", "position": 4}, {"id": "c7180d9c-3834-4c67-a679-2e4a013e0926", "color": "gray", "label": "Своя задача", "value": "MANUAL", "position": 5}]'::jsonb,
       null,
       null,
       true, false, true, false, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'kind');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'DATE_TIME', 'nextAt', 'Дата следующего шага',
       null, 'IconCalendarPlus',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'nextAt');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'outcome', 'Результат',
       null, 'IconFlag',
       '[{"id": "f152554b-0428-4b4d-a017-fdd09a8330e1", "color": "orange", "label": "Не отвечает", "value": "NO_ANSWER", "position": 0}, {"id": "5c0376d0-1dfc-4822-b56e-c052da0880cc", "color": "yellow", "label": "Думает", "value": "THINKING", "position": 1}, {"id": "1c0ab59f-7967-4e10-99c3-6953eac6a507", "color": "sky", "label": "Отложить надолго", "value": "POSTPONED", "position": 2}, {"id": "6bc00f2a-b120-44f5-9bab-a16c046bc1fe", "color": "blue", "label": "Договорились на показ", "value": "SHOWING_SET", "position": 3}, {"id": "a31fd7dc-2b09-4926-9b51-b4a21a32625f", "color": "red", "label": "Не пришёл", "value": "NO_SHOW", "position": 4}, {"id": "2c7fe9eb-02f8-478f-8351-6d1173581b03", "color": "blue", "label": "Перенесли", "value": "RESCHEDULED", "position": 5}, {"id": "7128580f-72fa-4103-ab52-5ca5f7989dde", "color": "purple", "label": "Внёс бронь", "value": "BOOKED", "position": 6}, {"id": "91b39564-f4f6-4c90-afa7-405863f01901", "color": "yellow", "label": "Договор подписан", "value": "CONTRACT_SIGNED", "position": 7}, {"id": "989d06f0-1712-42fa-b62e-3521ac5f5de8", "color": "orange", "label": "Переносится", "value": "DELAYED", "position": 8}, {"id": "e52703c0-9469-4ea4-b5e4-95f56eb0786f", "color": "green", "label": "Оплачено", "value": "PAID", "position": 9}, {"id": "dc5c2dc1-1918-4b7f-b090-75108286f655", "color": "red", "label": "Отказ", "value": "REFUSED", "position": 10}, {"id": "2598b20e-3b08-40bb-b624-f26d5cdda8fe", "color": "gray", "label": "Не наш клиент", "value": "NOT_OURS", "position": 11}, {"id": "51bec974-2b9f-43d3-97ce-e79333de1f5a", "color": "green", "label": "Сделал", "value": "COMPLETED", "position": 12}, {"id": "4ccaab63-cf71-4e31-bb1d-24550e77852c", "color": "gray", "label": "Отменить", "value": "DROPPED", "position": 13}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'outcome');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'priority', 'Важность',
       null, 'IconFlame',
       null,
       null,
       null,
       true, false, true, false, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'priority');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'DATE_TIME', 'scheduledAt', 'Когда делать',
       'День, когда берутся за дело. Просрочкой не считается — в отличие от дедлайна.', 'IconCalendarEvent',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'scheduledAt');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'DATE_TIME', 'slaDueAt', 'Срок по SLA',
       null, 'IconClockExclamation',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'slaDueAt');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'slaMinutes', 'SLA, мин',
       null, 'IconClock',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'slaMinutes');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'slaStatus', 'Статус SLA',
       null, 'IconAlertTriangle',
       '[{"id": "098cd65c-8030-4a58-a62e-03997ac1f616", "color": "green", "label": "В срок", "value": "ON_TIME", "position": 0}, {"id": "982c72d0-02c3-4365-8e7e-85f72e000b56", "color": "orange", "label": "Горит", "value": "WARNING", "position": 1}, {"id": "8c8f45da-0cfb-4571-bbad-991faaae0188", "color": "red", "label": "Просрочено", "value": "LATE", "position": 2}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'slaStatus');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'snoozeCount', 'Переносов',
       null, 'IconClockPause',
       null,
       null,
       '0'::jsonb,
       true, false, true, false, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'snoozeCount');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'team', 'Команда',
       'Команда исполнителя. Заполняется автоматически — по ней старший брокер видит задачи своих людей.', 'IconUsersGroup',
       '[{"id": "088f86ca-4b41-4f59-8410-3314feb4b0f5", "color": "blue", "label": "Керимбекова Айчурок", "value": "TEAM_1", "position": 0}, {"id": "40c18d28-343c-45f1-a326-99318f5dec21", "color": "green", "label": "Арстанбек кызы Таалайкан", "value": "TEAM_2", "position": 1}, {"id": "be57d431-8298-4c7e-9e30-a51124f2cbd1", "color": "orange", "label": "Алканов Тилек", "value": "TEAM_3", "position": 2}, {"id": "dd4ca6cc-8fbd-4afe-99a6-e84da4324073", "color": "purple", "label": "Бузурманкулов Дастан", "value": "TEAM_4", "position": 3}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'team');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'NUMBER', 'kulpunaiAgentId', 'Оператор KulpunAI',
       'Идентификатор оператора в KulpunAI. Связывает сотрудника с его учётной записью в чате.', 'IconMessageCircle',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'kulpunaiAgentId');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'seniority', 'Роль в команде',
       null, 'IconHierarchy',
       '[{"id": "6a09b5a9-ff73-4ee2-8f36-5afe5a5ec2ba", "color": "purple", "label": "Старший брокер", "value": "SENIOR", "position": 0}, {"id": "c56ae8d8-fe26-4820-9b13-826504fdbdb1", "color": "blue", "label": "Брокер", "value": "BROKER", "position": 1}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'seniority');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'team', 'Команда',
       null, 'IconUsersGroup',
       '[{"id": "b3cd4fa6-5ec8-4980-aeb0-77061acfb6ae", "color": "blue", "label": "Керимбекова Айчурок", "value": "TEAM_1", "position": 0}, {"id": "80504e4d-768d-489c-a519-f2033f1a4363", "color": "green", "label": "Арстанбек кызы Таалайкан", "value": "TEAM_2", "position": 1}, {"id": "46c93aa9-5f21-48b0-9e1f-bdd3b464b8c6", "color": "orange", "label": "Алканов Тилек", "value": "TEAM_3", "position": 2}, {"id": "7f32fcba-013f-4203-8220-d6f7b94532df", "color": "purple", "label": "Бузурманкулов Дастан", "value": "TEAM_4", "position": 3}]'::jsonb,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'team');
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, description, icon, options, settings,
   "defaultValue", "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'telegramChatId', 'Телеграм',
       'Куда боту слать личные уведомления. Заполняется само, когда человек открывает свою ссылку и нажимает «Старт».', 'IconBrandTelegram',
       null,
       null,
       null,
       true, false, false, true, true,
       false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o
    on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'telegramChatId');
