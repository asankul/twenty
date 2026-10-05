-- Виды: воронка, списки, карточка заявки.
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

-- ── Виды ─────────────────────────────────────────────────────────
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Opportunity Record Page Fields', o.id, 'FIELDS_WIDGET', 'IconList', null,
       0, false, false, 'SIDE_PANEL', null,
       null, null,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Без ответственного', o.id, 'KANBAN', 'IconUserQuestion', null,
       99, false, false, 'SIDE_PANEL', 'COUNT',
       null, gf.id,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  left join core."fieldMetadata" gf on gf."objectMetadataId" = o.id and gf.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Без ответственного'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Воронка', o.id, 'KANBAN', 'IconLayoutKanban', 'INDEX',
       0, false, false, 'SIDE_PANEL', 'COUNT',
       kf.id, gf.id,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  left join core."fieldMetadata" kf on kf."objectMetadataId" = o.id and kf.name = 'amount'
  left join core."fieldMetadata" gf on gf."objectMetadataId" = o.id and gf.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Воронка'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Все лиды', o.id, 'TABLE', 'IconList', null,
       1, false, false, 'SIDE_PANEL', null,
       null, null,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Все лиды'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Мои лиды', o.id, 'KANBAN', 'IconUserCheck', null,
       1, false, false, 'SIDE_PANEL', 'COUNT',
       null, gf.id,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  left join core."fieldMetadata" gf on gf."objectMetadataId" = o.id and gf.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Мои лиды'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'All Задачи', o.id, 'TABLE', 'IconTable', null,
       1, false, true, 'SIDE_PANEL', null,
       null, null,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'All Задачи'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Assigned to Me', o.id, 'TABLE', 'IconUserCircle', null,
       2, false, false, 'SIDE_PANEL', null,
       null, gf.id,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  left join core."fieldMetadata" gf on gf."objectMetadataId" = o.id and gf.name = 'status'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Assigned to Me'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'By Status', o.id, 'KANBAN', 'IconLayoutKanban', null,
       1, false, false, 'SIDE_PANEL', null,
       null, gf.id,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  left join core."fieldMetadata" gf on gf."objectMetadataId" = o.id and gf.name = 'status'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'By Status'
                      and v."deletedAt" is null);
insert into core.view
  (id, name, "objectMetadataId", type, icon, key, position, "isCompact", "isCustom",
   "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId",
   "mainGroupByFieldMetadataId", "shouldHideEmptyGroups", visibility, "anyFieldFilterValue",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Task Record Page Fields', o.id, 'FIELDS_WIDGET', 'IconList', null,
       0, false, false, 'SIDE_PANEL', null,
       null, null,
       false, 'WORKSPACE', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.view v
                    where v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields'
                      and v."deletedAt" is null);

-- ── Колонки видов ────────────────────────────────────────────────
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'budgetMax'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'rooms'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'phone'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 10,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'managerName'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 12,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'pointOfContact'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 15,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 17,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 19,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lostReason'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'amount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'district'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'updatedAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 20,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'comment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'closeDate'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'updatedBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'taskTargets'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'leadSource'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'noteTargets'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 6,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'attachments'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 7,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Opportunity Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'timelineActivities'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'name'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'amount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'phone'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'leadSource'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'closeDate'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'managerName'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'pointOfContact'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'name'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'amount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'phone'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'leadSource'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'closeDate'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'pointOfContact'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'managerName'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'name'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 1,
       'AVG', w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'amount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 10,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'budgetMax'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 11,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'managerName'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 12,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lostReason'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 13,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'leadSource'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 14,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'phone'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 15,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'district'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 16,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'comment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 17,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 18,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 19,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 20,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 21,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 22,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 23,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 3,
       'MIN', w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'closeDate'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'pointOfContact'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 6,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 7,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 8,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 180, 9,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'rooms'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'name'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'amount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'phone'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'leadSource'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'closeDate'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'pointOfContact'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 0, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'managerName'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 210, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'title'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, -1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'outcome'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'status'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'taskTargets'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'dueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 6,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 7,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'bodyV2'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 8,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 210, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'title'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, -1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'outcome'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'taskTargets'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdBy'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'dueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 6,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 7,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'bodyV2'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 8,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 210, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'By Status' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'title'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'By Status' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'status'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 3,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'By Status' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'dueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'By Status' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 6,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'By Status' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'createdAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 0,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'dueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 0, -1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'outcome'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 1,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'status'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 10,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kommentarii'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 11,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'scheduledAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 12,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 2,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 150, 4,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'taskTargets'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 5,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'attachments'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, false, 150, 6,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'timelineActivities'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 7,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 8,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaDueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewField"
  (id, "viewId", "fieldMetadataId", "isVisible", size, position, "aggregateOperation",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, true, 180, 9,
       null, w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Task Record Page Fields' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewField" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);

-- ── Сортировки ───────────────────────────────────────────────────
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'DESC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'DESC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Воронка' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'DESC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Все лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'DESC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'ASC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'dueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'DESC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'All Задачи' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'ASC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'dueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewSort"
  (id, "viewId", "fieldMetadataId", direction, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'DESC',
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewSort" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);

-- ── Фильтры ──────────────────────────────────────────────────────
insert into core."viewFilter"
  (id, "viewId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'IS_EMPTY', '[]', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Без ответственного' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewFilter" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewFilter"
  (id, "viewId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'IS', '{"selectedRecordIds": [], "isCurrentWorkspaceMemberSelected": true}', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Мои лиды' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewFilter" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
insert into core."viewFilter"
  (id, "viewId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), v.id, f.id, 'IS', '"{\"isCurrentWorkspaceMemberSelected\":true,\"selectedRecordIds\":[]}"', null,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core.view v on v."objectMetadataId" = o.id and v.name = 'Assigned to Me' and v."deletedAt" is null
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."viewFilter" x
                    where x."viewId" = v.id and x."fieldMetadataId" = f.id
                      and x."deletedAt" is null);
