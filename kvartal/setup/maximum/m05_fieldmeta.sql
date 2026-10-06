-- Метаданные новых полей школы.
--
-- Отдельным файлом от m04: колонка и перечисление должны существовать
-- до того, как на них сошлётся метаданное описание, а install.sh
-- оборачивает каждый файл в свою транзакцию.
--
-- Поля ищутся по паре «объект + имя», идентификаторы нигде не зашиты.

-- Филиал --------------------------------------------------------------
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon, options,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'branch', 'Филиал', 'IconBuildingStore',
       '[{"value":"UNSET","label":"Не указан","color":"gray","position":0}]'::jsonb,
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'branch');

-- Уровень английского --------------------------------------------------
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon, options,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'level', 'Уровень', 'IconChartBar',
       '[{"value":"UNKNOWN","label":"Не определён","color":"gray","position":0},
         {"value":"A1","label":"A1 — начальный","color":"sky","position":1},
         {"value":"A2","label":"A2 — ниже среднего","color":"turquoise","position":2},
         {"value":"B1","label":"B1 — средний","color":"blue","position":3},
         {"value":"B2","label":"B2 — выше среднего","color":"purple","position":4},
         {"value":"C1","label":"C1 — продвинутый","color":"green","position":5}]'::jsonb,
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'level');

-- Формат ---------------------------------------------------------------
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon, options,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'format', 'Формат', 'IconUsers',
       '[{"value":"GROUP","label":"Группа","color":"blue","position":0},
         {"value":"SOLO","label":"Индивидуально","color":"purple","position":1}]'::jsonb,
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'format');

-- Очно или онлайн ------------------------------------------------------
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon, options,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'SELECT', 'mode', 'Очно или онлайн', 'IconDeviceLaptop',
       '[{"value":"OFFLINE","label":"Очно","color":"green","position":0},
         {"value":"ONLINE","label":"Онлайн","color":"sky","position":1}]'::jsonb,
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'mode');

-- Удобный график -------------------------------------------------------
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'TEXT', 'schedule', 'Удобный график', 'IconCalendarTime',
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'schedule');

-- Когда пробное --------------------------------------------------------
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'DATE_TIME', 'trialAt', 'Когда пробное', 'IconCalendarEvent',
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'trialAt');

-- Дата возврата --------------------------------------------------------
-- Из статуса «Потерян» лид сам всплывёт обратно в очередь в этот день.
insert into core."fieldMetadata"
  (id, "objectMetadataId", type, name, label, icon, description,
   "isActive", "isSystem", "isUIReadOnly", "isUIEditable", "isNullable",
   "isLabelSyncedWithName", "isSystemSideEffect", "isAuditLogged", writability,
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), o.id, 'DATE_TIME', 'returnAt', 'Дата возврата', 'IconCalendarRepeat',
       'В этот день потерянный лид автоматически вернётся в очередь',
       true, false, false, true, true, false, false, true, 'OPEN',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldMetadata" f
                    where f."objectMetadataId" = o.id and f.name = 'returnAt');
