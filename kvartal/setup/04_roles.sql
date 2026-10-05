-- Роли и права кабинета.
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

-- ── Роли ─────────────────────────────────────────────────────────
insert into core.role
  (id, label, description, icon, "canReadAllObjectRecords", "canUpdateAllObjectRecords",
   "canSoftDeleteAllObjectRecords", "canDestroyAllObjectRecords", "canUpdateAllSettings",
   "canAccessAllTools", "isEditable", "canBeAssignedToUsers", "canBeAssignedToAgents",
   "canBeAssignedToApiKeys", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), 'Member', 'Member role', 'IconUser',
       true, true, true, true, false, true,
       true, true, false, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.role r
                    where r."workspaceId" = w.id and r.label = 'Member');
insert into core.role
  (id, label, description, icon, "canReadAllObjectRecords", "canUpdateAllObjectRecords",
   "canSoftDeleteAllObjectRecords", "canDestroyAllObjectRecords", "canUpdateAllSettings",
   "canAccessAllTools", "isEditable", "canBeAssignedToUsers", "canBeAssignedToAgents",
   "canBeAssignedToApiKeys", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), 'Менеджер', 'Видит свои заявки и нераспределённые', 'IconUser',
       false, false, false, false, false, false,
       true, true, false, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.role r
                    where r."workspaceId" = w.id and r.label = 'Менеджер');
insert into core.role
  (id, label, description, icon, "canReadAllObjectRecords", "canUpdateAllObjectRecords",
   "canSoftDeleteAllObjectRecords", "canDestroyAllObjectRecords", "canUpdateAllSettings",
   "canAccessAllTools", "isEditable", "canBeAssignedToUsers", "canBeAssignedToAgents",
   "canBeAssignedToApiKeys", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), 'Операционный директор', 'Видит всё для аудита, но не правит записи и не меняет настройки', 'IconEyeglass',
       true, false, false, false, false, false,
       true, true, false, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.role r
                    where r."workspaceId" = w.id and r.label = 'Операционный директор');
insert into core.role
  (id, label, description, icon, "canReadAllObjectRecords", "canUpdateAllObjectRecords",
   "canSoftDeleteAllObjectRecords", "canDestroyAllObjectRecords", "canUpdateAllSettings",
   "canAccessAllTools", "isEditable", "canBeAssignedToUsers", "canBeAssignedToAgents",
   "canBeAssignedToApiKeys", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), 'Старший брокер', 'Видит лиды своей команды, свои и нераспределённые', 'IconUsersGroup',
       false, false, false, false, false, false,
       true, true, false, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core.role r
                    where r."workspaceId" = w.id and r.label = 'Старший брокер');

-- ── Права по объектам ────────────────────────────────────────────
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, false, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, false, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);
insert into core."objectPermission"
  (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords",
   "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId",
   "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, true, true, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."objectPermission" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id);

-- ── Права по полям ───────────────────────────────────────────────
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'waitingSince'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaDueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'snoozeCount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Admin'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kulpunaiAgentId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'waitingSince'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaDueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'snoozeCount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kulpunaiAgentId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'seniority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Member'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'waitingSince'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaDueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'snoozeCount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kulpunaiAgentId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'seniority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'waitingSince'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaDueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'snoozeCount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kulpunaiAgentId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'seniority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Операционный директор'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'channel'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatContactId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatConversationId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'chatLink'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'contactValue'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'hasChat'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'lastMessage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'stage'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchAge'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'touchStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'waitingSince'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kind'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'priority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaDueAt'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaMinutes'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'slaStatus'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'snoozeCount'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'kulpunaiAgentId'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'seniority'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);
insert into core."fieldPermission"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue",
   "canUpdateFieldValue", "workspaceId", "applicationId", "universalIdentifier",
   "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id, true, false,
       w.id, w."workspaceCustomApplicationId", gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."fieldPermission" p
                    where p."roleId" = r.id and p."fieldMetadataId" = f.id);

-- ── Построчные правила: группы ───────────────────────────────────
insert into core."rowLevelPermissionPredicateGroup"
  (id, "roleId", "objectMetadataId", "logicalOperator",
   "positionInRowLevelPermissionPredicateGroup", "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, 'OR',
       0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicateGroup" g
                    where g."roleId" = r.id and g."objectMetadataId" = o.id
                      and g."deletedAt" is null);
insert into core."rowLevelPermissionPredicateGroup"
  (id, "roleId", "objectMetadataId", "logicalOperator",
   "positionInRowLevelPermissionPredicateGroup", "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, 'OR',
       null, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicateGroup" g
                    where g."roleId" = r.id and g."objectMetadataId" = o.id
                      and g."deletedAt" is null);
insert into core."rowLevelPermissionPredicateGroup"
  (id, "roleId", "objectMetadataId", "logicalOperator",
   "positionInRowLevelPermissionPredicateGroup", "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, 'OR',
       0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicateGroup" g
                    where g."roleId" = r.id and g."objectMetadataId" = o.id
                      and g."deletedAt" is null);
insert into core."rowLevelPermissionPredicateGroup"
  (id, "roleId", "objectMetadataId", "logicalOperator",
   "positionInRowLevelPermissionPredicateGroup", "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, 'OR',
       null, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicateGroup" g
                    where g."roleId" = r.id and g."objectMetadataId" = o.id
                      and g."deletedAt" is null);
insert into core."rowLevelPermissionPredicateGroup"
  (id, "roleId", "objectMetadataId", "logicalOperator",
   "positionInRowLevelPermissionPredicateGroup", "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, 'OR',
       null, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicateGroup" g
                    where g."roleId" = r.id and g."objectMetadataId" = o.id
                      and g."deletedAt" is null);

-- ── Построчные правила: условия ──────────────────────────────────
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'id'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS_EMPTY',
       null, null,
       null, null,
       g.id, 1, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS_EMPTY'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'id'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS_EMPTY',
       null, null,
       null, null,
       g.id, 1, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Менеджер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS_EMPTY'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 1, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'id'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS_EMPTY',
       null, null,
       null, null,
       g.id, 2, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'owner'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS_EMPTY'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'id'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS_EMPTY',
       null, null,
       null, null,
       g.id, 1, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'assignee'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS_EMPTY'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 2, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS',
       null, null,
       wmf.id, null,
       g.id, 0, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
  join core."objectMetadata" wmo on wmo."workspaceId" = w.id and wmo."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" wmf on wmf."objectMetadataId" = wmo.id and wmf.name = 'team'
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS'
                      and p."deletedAt" is null);
insert into core."rowLevelPermissionPredicate"
  (id, "roleId", "objectMetadataId", "fieldMetadataId", operand, value, "subFieldName",
   "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName",
   "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup",
   "workspaceId", "applicationId", "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), r.id, o.id, f.id,
       'IS_EMPTY',
       null, null,
       null, null,
       g.id, 1, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
  join core.role r on r."workspaceId" = w.id and r.label = 'Старший брокер'
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
  join core."fieldMetadata" f on f."objectMetadataId" = o.id and f.name = 'team'
  join core."rowLevelPermissionPredicateGroup" g
    on g."roleId" = r.id and g."objectMetadataId" = o.id and g."deletedAt" is null
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."rowLevelPermissionPredicate" p
                    where p."roleId" = r.id and p."objectMetadataId" = o.id
                      and p."fieldMetadataId" = f.id
                      and p.operand = 'IS_EMPTY'
                      and p."deletedAt" is null);
