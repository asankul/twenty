-- Названия полей и видов.
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

-- ── Названия полей ───────────────────────────────────────────────
update core."fieldMetadata" f
   set label = 'Active Stream ID',
       description = 'Active Stream ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'activeStreamId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Active Stream ID';
update core."fieldMetadata" f
   set label = 'Archived At',
       description = 'Archived At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'archivedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Archived At';
update core."fieldMetadata" f
   set label = 'Attachments',
       description = 'Attachments linked to the chat thread',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attachments';
update core."fieldMetadata" f
   set label = 'Context Window Tokens',
       description = 'Context Window Tokens',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'contextWindowTokens'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Context Window Tokens';
update core."fieldMetadata" f
   set label = 'Conversation Size',
       description = 'Conversation Size',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'conversationSize'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Conversation Size';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Last Stream Error',
       description = 'Last Stream Error',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'lastStreamError'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Last Stream Error';
update core."fieldMetadata" f
   set label = 'Messages',
       description = 'Messages',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'messages'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Messages';
update core."fieldMetadata" f
   set label = 'Pending Question Message ID',
       description = 'Pending Question Message ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'pendingQuestionMessageId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Pending Question Message ID';
update core."fieldMetadata" f
   set label = 'Record Targets',
       description = 'Records this thread is attached to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'recordTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Record Targets';
update core."fieldMetadata" f
   set label = 'Title',
       description = 'Title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'title'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Title';
update core."fieldMetadata" f
   set label = 'Total Cache Creation Tokens',
       description = 'Total Cache Creation Tokens',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'totalCacheCreationTokens'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Total Cache Creation Tokens';
update core."fieldMetadata" f
   set label = 'Total Cache Read Tokens',
       description = 'Total Cache Read Tokens',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'totalCacheReadTokens'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Total Cache Read Tokens';
update core."fieldMetadata" f
   set label = 'Total Input Credits',
       description = 'Total Input Credits',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'totalInputCredits'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Total Input Credits';
update core."fieldMetadata" f
   set label = 'Total Input Tokens',
       description = 'Total Input Tokens',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'totalInputTokens'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Total Input Tokens';
update core."fieldMetadata" f
   set label = 'Total Output Credits',
       description = 'Total Output Credits',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'totalOutputCredits'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Total Output Credits';
update core."fieldMetadata" f
   set label = 'Total Output Tokens',
       description = 'Total Output Tokens',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'totalOutputTokens'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Total Output Tokens';
update core."fieldMetadata" f
   set label = 'Turns',
       description = 'Turns',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'turns'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Turns';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'User Workspace ID',
       description = 'User Workspace ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'userWorkspaceId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'User Workspace ID';
update core."fieldMetadata" f
   set label = 'Workspace Member',
       description = 'Workspace member who owns the thread',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThread'
 where f."objectMetadataId" = o.id
   and f.name = 'workspaceMember'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workspace Member';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Deleted At',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Deleted At';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Company',
       description = 'Record the chat is attached to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Company';
update core."fieldMetadata" f
   set label = 'Opportunity',
       description = 'Record the chat is attached to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunity';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'Record the chat is attached to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'TaskComment',
       description = 'AgentChatThreadTargets Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTaskComment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'TaskComment';
update core."fieldMetadata" f
   set label = 'Thread',
       description = 'Thread',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'thread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Thread';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentChatThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Agent ID',
       description = 'Agent ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'agentId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Agent ID';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Is Hidden',
       description = 'Is Hidden',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'isHidden'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Is Hidden';
update core."fieldMetadata" f
   set label = 'Parts',
       description = 'Parts',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'parts'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Parts';
update core."fieldMetadata" f
   set label = 'Processed At',
       description = 'Processed At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'processedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Processed At';
update core."fieldMetadata" f
   set label = 'Role',
       description = 'Role',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'role'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Role';
update core."fieldMetadata" f
   set label = 'Sender application ID',
       description = 'Sender application ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'senderApplicationId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Sender application ID';
update core."fieldMetadata" f
   set label = 'Sender workspace membership ID',
       description = 'Sender workspace membership ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'senderUserWorkspaceId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Sender workspace membership ID';
update core."fieldMetadata" f
   set label = 'Status',
       description = 'Status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'status'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Status';
update core."fieldMetadata" f
   set label = 'Thread',
       description = 'Thread',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'thread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Thread';
update core."fieldMetadata" f
   set label = 'Turn',
       description = 'Turn',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'turn'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Turn';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessage'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Error Details',
       description = 'Error Details',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'errorDetails'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Error Details';
update core."fieldMetadata" f
   set label = 'Error Message',
       description = 'Error Message',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'errorMessage'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Error Message';
update core."fieldMetadata" f
   set label = 'File Filename',
       description = 'File Filename',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'fileFilename'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'File Filename';
update core."fieldMetadata" f
   set label = 'File ID',
       description = 'File ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'fileId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'File ID';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Message',
       description = 'Message',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'message'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message';
update core."fieldMetadata" f
   set label = 'Order Index',
       description = 'Order Index',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'orderIndex'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Order Index';
update core."fieldMetadata" f
   set label = 'Provider Executed',
       description = 'Provider Executed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'providerExecuted'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Provider Executed';
update core."fieldMetadata" f
   set label = 'Provider Metadata',
       description = 'Provider Metadata',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'providerMetadata'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Provider Metadata';
update core."fieldMetadata" f
   set label = 'Reasoning Content',
       description = 'Reasoning Content',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'reasoningContent'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Reasoning Content';
update core."fieldMetadata" f
   set label = 'Source Document Filename',
       description = 'Source Document Filename',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceDocumentFilename'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source Document Filename';
update core."fieldMetadata" f
   set label = 'Source Document Media Type',
       description = 'Source Document Media Type',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceDocumentMediaType'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source Document Media Type';
update core."fieldMetadata" f
   set label = 'Source Document Source ID',
       description = 'Source Document Source ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceDocumentSourceId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source Document Source ID';
update core."fieldMetadata" f
   set label = 'Source Document Title',
       description = 'Source Document Title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceDocumentTitle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source Document Title';
update core."fieldMetadata" f
   set label = 'Source URL Source ID',
       description = 'Source URL Source ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceUrlSourceId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source URL Source ID';
update core."fieldMetadata" f
   set label = 'Source URL Title',
       description = 'Source URL Title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceUrlTitle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source URL Title';
update core."fieldMetadata" f
   set label = 'Source URL URL',
       description = 'Source URL URL',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceUrlUrl'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source URL URL';
update core."fieldMetadata" f
   set label = 'State',
       description = 'State',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'state'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'State';
update core."fieldMetadata" f
   set label = 'Text Content',
       description = 'Text Content',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'textContent'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Text Content';
update core."fieldMetadata" f
   set label = 'Tool Call ID',
       description = 'Tool Call ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'toolCallId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Tool Call ID';
update core."fieldMetadata" f
   set label = 'Tool Input',
       description = 'Tool Input',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'toolInput'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Tool Input';
update core."fieldMetadata" f
   set label = 'Tool Name',
       description = 'Tool Name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'toolName'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Tool Name';
update core."fieldMetadata" f
   set label = 'Tool Output',
       description = 'Tool Output',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'toolOutput'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Tool Output';
update core."fieldMetadata" f
   set label = 'Type',
       description = 'Type',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'type'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Type';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentMessagePart'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Agent ID',
       description = 'Agent ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'agentId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Agent ID';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Evaluations',
       description = 'Evaluations',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'evaluations'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Evaluations';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Messages',
       description = 'Messages',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'messages'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Messages';
update core."fieldMetadata" f
   set label = 'Thread',
       description = 'Thread',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'thread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Thread';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurn'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Comment',
       description = 'Comment',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'comment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Comment';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Score',
       description = 'Score',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'score'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Score';
update core."fieldMetadata" f
   set label = 'Turn',
       description = 'Turn',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'turn'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Turn';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'agentTurnEvaluation'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'File',
       description = 'Attachment file',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'file'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'File';
update core."fieldMetadata" f
   set label = 'File category',
       description = 'Attachment file category',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'fileCategory'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'File category';
update core."fieldMetadata" f
   set label = 'Full path',
       description = 'Attachment full path',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'fullPath'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Full path';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'Attachment name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Attachment record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetAgentChatThread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetDashboard'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetNote'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTask'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachments Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTaskComment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Attached to',
       description = 'Attachment target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'targetWorkflow'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attached to';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Handle',
       description = 'Handle',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'handle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Handle';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Blocklist record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Scope',
       description = 'Whether the handle is blocked for a single workspace member or for the whole workspace',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'scope'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Scope';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'WorkspaceMember',
       description = 'WorkspaceMember',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where f."objectMetadataId" = o.id
   and f.name = 'workspaceMember'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'WorkspaceMember';
update core."fieldMetadata" f
   set label = 'Channel ID',
       description = 'Channel ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarChannelId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Channel ID';
update core."fieldMetadata" f
   set label = 'Event ID',
       description = 'Event ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEvent'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event ID';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Event external ID',
       description = 'Event external ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'eventExternalId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event external ID';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Calendar channel event association record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Recurring Event ID',
       description = 'Recurring Event ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'recurringEventExternalId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Recurring Event ID';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Calendar Channel Event Associations',
       description = 'Calendar Channel Event Associations',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarChannelEventAssociations'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar Channel Event Associations';
update core."fieldMetadata" f
   set label = 'Event Participants',
       description = 'Event Participants',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventParticipants'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event Participants';
update core."fieldMetadata" f
   set label = 'Relations',
       description = 'Calendar event targets',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Relations';
update core."fieldMetadata" f
   set label = 'Call Recordings',
       description = 'Call Recordings',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'callRecordings'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Call Recordings';
update core."fieldMetadata" f
   set label = 'Meet Link',
       description = 'Meet Link',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'conferenceLink'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Meet Link';
update core."fieldMetadata" f
   set label = 'Conference Solution',
       description = 'Conference Solution',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'conferenceSolution'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Conference Solution';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Description',
       description = 'Description',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'description'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Description';
update core."fieldMetadata" f
   set label = 'End Date',
       description = 'End Date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'endsAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'End Date';
update core."fieldMetadata" f
   set label = 'Creation DateTime',
       description = 'Creation DateTime',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'externalCreatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Creation DateTime';
update core."fieldMetadata" f
   set label = 'Update DateTime',
       description = 'Update DateTime',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'externalUpdatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Update DateTime';
update core."fieldMetadata" f
   set label = 'iCal UID',
       description = 'iCal UID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'iCalUid'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'iCal UID';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Is canceled',
       description = 'Is canceled',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'isCanceled'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Is canceled';
update core."fieldMetadata" f
   set label = 'Is Full Day',
       description = 'Is Full Day',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'isFullDay'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Is Full Day';
update core."fieldMetadata" f
   set label = 'Location',
       description = 'Location',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'location'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Location';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Calendar event record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Start Date',
       description = 'Start Date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'startsAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Start Date';
update core."fieldMetadata" f
   set label = 'Title',
       description = 'Title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'title'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Title';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Event ID',
       description = 'Event ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEvent'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event ID';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Display Name',
       description = 'Display Name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'displayName'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Display Name';
update core."fieldMetadata" f
   set label = 'Handle',
       description = 'Handle',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'handle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Handle';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Is Organizer',
       description = 'Is Organizer',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'isOrganizer'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Is Organizer';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'Person',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'person'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Calendar event participant record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Response Status',
       description = 'Response Status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'responseStatus'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Response Status';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Workspace Member',
       description = 'Workspace Member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'workspaceMember'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workspace Member';
update core."fieldMetadata" f
   set label = 'Calendar event',
       description = 'Calendar event target event',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEvent'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar event';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Automatically assigned',
       description = 'Whether current participant rules justify this target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'isAutomaticallyAssigned'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Automatically assigned';
update core."fieldMetadata" f
   set label = 'Manually assigned',
       description = 'Whether a user explicitly assigned this target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'isManuallyAssigned'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Manually assigned';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Target record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Company',
       description = 'Target record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Company';
update core."fieldMetadata" f
   set label = 'Opportunity',
       description = 'Target record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunity';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'Target record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Application ID',
       description = 'Installed source app that manages or ingested this recording',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'applicationId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Application ID';
update core."fieldMetadata" f
   set label = 'Audio',
       description = 'Audio-only recording',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'audio'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Audio';
update core."fieldMetadata" f
   set label = 'Calendar Event',
       description = 'Calendar Event',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEvent'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar Event';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Ended At',
       description = 'Actual recording end',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'endedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Ended At';
update core."fieldMetadata" f
   set label = 'External Bot ID',
       description = 'Source app bot/session id, when the source supports bots',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'externalBotId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'External Bot ID';
update core."fieldMetadata" f
   set label = 'External Recording ID',
       description = 'Source app recording id, when present',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'externalRecordingId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'External Recording ID';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Call recording record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Request Status',
       description = 'Recording request status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'recordingRequestStatus'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Request Status';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Started At',
       description = 'Actual recording start',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'startedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Started At';
update core."fieldMetadata" f
   set label = 'Status',
       description = 'Recording lifecycle status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'status'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Status';
update core."fieldMetadata" f
   set label = 'Summary',
       description = 'Recording summary',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'summary'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Summary';
update core."fieldMetadata" f
   set label = 'Title',
       description = 'Meeting title from the calendar event',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'title'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Title';
update core."fieldMetadata" f
   set label = 'Transcript',
       description = 'Normalized diarized transcript',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'transcript'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Transcript';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Video',
       description = 'Video recording',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where f."objectMetadataId" = o.id
   and f.name = 'video'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Video';
update core."fieldMetadata" f
   set label = 'Bounced At',
       description = 'Bounced At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'bouncedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Bounced At';
update core."fieldMetadata" f
   set label = 'Campaign ID',
       description = 'Campaign ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'campaignId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Campaign ID';
update core."fieldMetadata" f
   set label = 'Claim Expires At',
       description = 'Claim Expires At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'claimExpiresAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Claim Expires At';
update core."fieldMetadata" f
   set label = 'Claim Token',
       description = 'Claim Token',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'claimToken'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Claim Token';
update core."fieldMetadata" f
   set label = 'Complained At',
       description = 'Complained At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'complainedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Complained At';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Deleted At',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Deleted At';
update core."fieldMetadata" f
   set label = 'Delivered At',
       description = 'Delivered At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'deliveredAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Delivered At';
update core."fieldMetadata" f
   set label = 'Failure Reason',
       description = 'Failure Reason',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'failureReason'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Failure Reason';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Person ID',
       description = 'Person ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'personId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person ID';
update core."fieldMetadata" f
   set label = 'Provider Message ID',
       description = 'Provider Message ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'providerMessageId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Provider Message ID';
update core."fieldMetadata" f
   set label = 'Recipient Email',
       description = 'Recipient Email',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'recipientEmail'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Recipient Email';
update core."fieldMetadata" f
   set label = 'Rejected At',
       description = 'Rejected At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'rejectedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Rejected At';
update core."fieldMetadata" f
   set label = 'Rendering Failed At',
       description = 'Rendering Failed At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'renderingFailedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Rendering Failed At';
update core."fieldMetadata" f
   set label = 'Sent At',
       description = 'Sent At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'sentAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Sent At';
update core."fieldMetadata" f
   set label = 'Skip Reason',
       description = 'Skip Reason',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'skipReason'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Skip Reason';
update core."fieldMetadata" f
   set label = 'State',
       description = 'State',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'state'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'State';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'campaignDelivery'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Ответственный',
       description = 'Your team member responsible for managing the company account',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'accountOwner'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Ответственный';
update core."fieldMetadata" f
   set label = 'Адрес',
       description = 'Address of the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'address'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Адрес';
update core."fieldMetadata" f
   set label = 'Chats',
       description = 'Chats tied to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'agentChatThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Chats';
update core."fieldMetadata" f
   set label = 'Годовой оборот',
       description = 'The company''s total annual revenue',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'annualRevenue'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Годовой оборот';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Attachments linked to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Calendar events',
       description = 'Calendar events tied to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar events';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Сайт',
       description = 'The company website URL. We use this url to fetch the company icon',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'domainName'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Сайт';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Linkedin',
       description = 'The company Linkedin account',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'linkedinLink'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Linkedin';
update core."fieldMetadata" f
   set label = 'Emails',
       description = 'Message threads tied to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Emails';
update core."fieldMetadata" f
   set label = 'Название',
       description = 'The company name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Название';
update core."fieldMetadata" f
   set label = 'Заметки',
       description = 'Notes tied to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'noteTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Заметки';
update core."fieldMetadata" f
   set label = 'Заявки',
       description = 'Opportunities linked to the company.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'opportunities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Заявки';
update core."fieldMetadata" f
   set label = 'Контакты',
       description = 'People linked to the company.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'people'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Контакты';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Company record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Задачи',
       description = 'Tasks tied to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'taskTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Задачи';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline Activities linked to the company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Attachments linked to the dashboard',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Page Layout ID',
       description = 'Dashboard page layout',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'pageLayoutId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Page Layout ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Dashboard record Position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline activities linked to the dashboard',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Title',
       description = 'Dashboard title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'title'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Title';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Header message ID',
       description = 'Message id from the message header',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'headerMessageId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Header message ID';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Is draft',
       description = 'Whether this message is an unsent draft synced from the provider',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'isDraft'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Is draft';
update core."fieldMetadata" f
   set label = 'Campaign',
       description = 'The campaign this message was sent as part of',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'messageCampaign'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Campaign';
update core."fieldMetadata" f
   set label = 'Message Channel Association',
       description = 'Messages from the channel.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'messageChannelMessageAssociations'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Channel Association';
update core."fieldMetadata" f
   set label = 'Message Participants',
       description = 'Message Participants',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'messageParticipants'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Participants';
update core."fieldMetadata" f
   set label = 'Message Thread ID',
       description = 'Message Thread ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Thread ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Message record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Received At',
       description = 'The date the message was received',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'receivedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Received At';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Subject',
       description = 'Subject',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'subject'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Subject';
update core."fieldMetadata" f
   set label = 'Text',
       description = 'Text',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'text'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Text';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Body',
       description = 'Email body sent to recipients',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'bodyTemplate'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Body';
update core."fieldMetadata" f
   set label = 'Bounced count',
       description = 'Number of emails that bounced',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'bouncedCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Bounced count';
update core."fieldMetadata" f
   set label = 'Complained count',
       description = 'Number of spam complaints received',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'complainedCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Complained count';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Delivered count',
       description = 'Number of emails confirmed delivered',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'deliveredCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Delivered count';
update core."fieldMetadata" f
   set label = 'Failed count',
       description = 'Number of emails that failed to send',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'failedCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Failed count';
update core."fieldMetadata" f
   set label = 'From address',
       description = 'Sender address for the campaign',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'fromAddress'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'From address';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'List',
       description = 'The list this campaign was sent to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'list'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'List';
update core."fieldMetadata" f
   set label = 'Messages',
       description = 'Messages sent as part of this campaign',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'messages'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Messages';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'Internal name of the campaign',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Email campaign record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Recipients',
       description = 'The people this campaign was sent to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'recipients'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Recipients';
update core."fieldMetadata" f
   set label = 'Scheduled at',
       description = 'When the campaign is due to start sending',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'scheduledAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Scheduled at';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Sent at',
       description = 'When the campaign finished sending',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'sentAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Sent at';
update core."fieldMetadata" f
   set label = 'Sent count',
       description = 'Number of emails sent',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'sentCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Sent count';
update core."fieldMetadata" f
   set label = 'Skipped count',
       description = 'Number of recipients skipped without being emailed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'skippedCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Skipped count';
update core."fieldMetadata" f
   set label = 'Status',
       description = 'Campaign lifecycle status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'status'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Status';
update core."fieldMetadata" f
   set label = 'Subject',
       description = 'Email subject line',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'subject'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Subject';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Events linked to the campaign',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Unsubscribe topic id',
       description = 'The unsubscribe topic this campaign was sent under',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'unsubscribeTopicId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Unsubscribe topic id';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Direction',
       description = 'Message Direction',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'direction'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Direction';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Message ID',
       description = 'Message ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'message'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message ID';
update core."fieldMetadata" f
   set label = 'Message Channel ID',
       description = 'Message Channel ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'messageChannelId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Channel ID';
update core."fieldMetadata" f
   set label = 'Message External ID',
       description = 'Message id from the messaging provider',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'messageExternalId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message External ID';
update core."fieldMetadata" f
   set label = 'Message Folders',
       description = 'Message Folders (supports multiple folders/labels)',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'messageFolders'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Folders';
update core."fieldMetadata" f
   set label = 'Message Thread ID',
       description = 'Message Thread ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Thread ID';
update core."fieldMetadata" f
   set label = 'Thread External ID',
       description = 'Thread id from the messaging provider',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThreadExternalId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Thread External ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Message channel message association record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Message Channel Message Association',
       description = 'Message Channel Message Association',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'messageChannelMessageAssociation'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Channel Message Association';
update core."fieldMetadata" f
   set label = 'Message Folder',
       description = 'Message Folder',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'messageFolderId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Folder';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Message channel message association message folder record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Campaigns',
       description = 'Campaigns sent to this list',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'campaigns'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Campaigns';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Description',
       description = 'What this list is for',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'description'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Description';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Members',
       description = 'People in this list',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'members'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Members';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'The list name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'List record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Events linked to the list',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'List',
       description = 'The list the person belongs to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'list'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'List';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'The person in the list',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'person'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'List member record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Display Name',
       description = 'Display Name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'displayName'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Display Name';
update core."fieldMetadata" f
   set label = 'Handle',
       description = 'Handle',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'handle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Handle';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Message',
       description = 'Message',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'message'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message';
update core."fieldMetadata" f
   set label = 'Campaign',
       description = 'The campaign this participant was a recipient of',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'messageCampaign'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Campaign';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'Person',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'person'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Message Participant record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Role',
       description = 'Role',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'role'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Role';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Workspace Member',
       description = 'Workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where f."objectMetadataId" = o.id
   and f.name = 'workspaceMember'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workspace Member';
update core."fieldMetadata" f
   set label = 'Created At',
       description = 'Created At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created At';
update core."fieldMetadata" f
   set label = 'Deleted At',
       description = 'Deleted At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Deleted At';
update core."fieldMetadata" f
   set label = 'Email Address',
       description = 'Email Address',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'emailAddress'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Email Address';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Provider Event ID',
       description = 'Provider Event ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'providerEventId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Provider Event ID';
update core."fieldMetadata" f
   set label = 'Reason',
       description = 'Reason',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'reason'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Reason';
update core."fieldMetadata" f
   set label = 'Source',
       description = 'Source',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'source'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source';
update core."fieldMetadata" f
   set label = 'Unsubscribe Topic ID',
       description = 'Unsubscribe Topic ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'unsubscribeTopicId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Unsubscribe Topic ID';
update core."fieldMetadata" f
   set label = 'Updated At',
       description = 'Updated At',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageSuppression'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated At';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Message Channel Association',
       description = 'Messages from the channel.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'messageChannelMessageAssociations'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Channel Association';
update core."fieldMetadata" f
   set label = 'Messages',
       description = 'Messages from the thread.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'messages'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Messages';
update core."fieldMetadata" f
   set label = 'Relations',
       description = 'Message thread targets',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Relations';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Message Thread record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Subject',
       description = 'Subject',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'subject'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Subject';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Automatically assigned',
       description = 'Whether current participant rules justify this target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'isAutomaticallyAssigned'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Automatically assigned';
update core."fieldMetadata" f
   set label = 'Manually assigned',
       description = 'Whether a user explicitly assigned this target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'isManuallyAssigned'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Manually assigned';
update core."fieldMetadata" f
   set label = 'Message thread',
       description = 'Message thread target thread',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThread'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message thread';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Target record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Company',
       description = 'Target record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Company';
update core."fieldMetadata" f
   set label = 'Opportunity',
       description = 'Target record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunity';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'Target record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThreadTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Note attachments',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Текст',
       description = 'Note body',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'bodyV2'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Текст';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Заметки',
       description = 'Note targets',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'noteTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Заметки';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Note record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline Activities linked to the note.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Заголовок',
       description = 'Note title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'title'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Заголовок';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Note',
       description = 'NoteTarget note',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'note'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Note';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'NoteTarget record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Company',
       description = 'NoteTarget target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Company';
update core."fieldMetadata" f
   set label = 'Opportunity',
       description = 'NoteTarget target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunity';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'NoteTarget target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'TaskComment',
       description = 'NoteTargets Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTaskComment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'TaskComment';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Chats',
       description = 'Chats tied to the opportunity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'agentChatThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Chats';
update core."fieldMetadata" f
   set label = 'Сумма сделки',
       description = 'Opportunity amount',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'amount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Сумма сделки';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Attachments linked to the opportunity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Бюджет до',
       description = 'Верхняя граница',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'budgetMax'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Бюджет до';
update core."fieldMetadata" f
   set label = 'Calendar events',
       description = 'Calendar events tied to the opportunity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar events';
update core."fieldMetadata" f
   set label = 'Канал',
       description = 'Откуда пришло обращение',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'channel'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Канал';
update core."fieldMetadata" f
   set label = 'Номер контакта',
       description = 'Идентификатор контакта в KulpunAI. Нужен, чтобы записать в чат ссылку на эту заявку.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'chatContactId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Номер контакта';
update core."fieldMetadata" f
   set label = 'Номер диалога',
       description = 'Идентификатор диалога в KulpunAI. Заполняется автоматически, по нему идёт синхронизация назначения.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'chatConversationId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Номер диалога';
update core."fieldMetadata" f
   set label = 'Переписка',
       description = 'Диалог в мессенджере',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'chatLink'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Переписка';
update core."fieldMetadata" f
   set label = 'Дата закрытия',
       description = 'Opportunity close date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'closeDate'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Дата закрытия';
update core."fieldMetadata" f
   set label = 'Примечание',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'comment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Примечание';
update core."fieldMetadata" f
   set label = 'Объект',
       description = 'Opportunity company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'company'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Объект';
update core."fieldMetadata" f
   set label = 'Контакт в канале',
       description = 'Ник или номер, как пришёл',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'contactValue'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Контакт в канале';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Район',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'district'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Район';
update core."fieldMetadata" f
   set label = 'Есть переписка',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'hasChat'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Есть переписка';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Последнее сообщение',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'lastMessage'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Последнее сообщение';
update core."fieldMetadata" f
   set label = 'Источник',
       description = 'Откуда узнали',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'leadSource'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Источник';
update core."fieldMetadata" f
   set label = 'Причина потери',
       description = 'Почему ушёл из воронки',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'lostReason'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Причина потери';
update core."fieldMetadata" f
   set label = 'Ответственный в старой системе',
       description = 'Менеджер из прежней системы',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'managerName'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Ответственный в старой системе';
update core."fieldMetadata" f
   set label = 'Emails',
       description = 'Message threads tied to the opportunity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Emails';
update core."fieldMetadata" f
   set label = 'Клиент',
       description = 'The opportunity name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Клиент';
update core."fieldMetadata" f
   set label = 'Заметки',
       description = 'Notes tied to the opportunity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'noteTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Заметки';
update core."fieldMetadata" f
   set label = 'Ответственный',
       description = 'Opportunity owner',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'owner'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Ответственный';
update core."fieldMetadata" f
   set label = 'Телефон',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'phone'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Телефон';
update core."fieldMetadata" f
   set label = 'Контактное лицо',
       description = 'Opportunity point of contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'pointOfContact'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Контактное лицо';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Opportunity record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Важность',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'priority'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Важность';
update core."fieldMetadata" f
   set label = 'Комнат',
       description = '0 — студия',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'rooms'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Комнат';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Стадия',
       description = 'Opportunity stage',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'stage'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Стадия';
update core."fieldMetadata" f
   set label = 'Задачи',
       description = 'Tasks tied to the opportunity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'taskTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Задачи';
update core."fieldMetadata" f
   set label = 'Команда',
       description = 'Команда ответственного. Заполняется автоматически, менять вручную нельзя.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'team'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Команда';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline Activities linked to the opportunity.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Без ответа',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'touchAge'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Без ответа';
update core."fieldMetadata" f
   set label = 'Минут до касания',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'touchMinutes'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Минут до касания';
update core."fieldMetadata" f
   set label = 'Первое касание',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'touchStatus'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Первое касание';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Ждёт с',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'waitingSince'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Ждёт с';
update core."fieldMetadata" f
   set label = 'Chats',
       description = 'Chats tied to the contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'agentChatThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Chats';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Attachments linked to the contact.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Avatar File',
       description = 'Contact''s avatar file',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'avatarFile'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Avatar File';
update core."fieldMetadata" f
   set label = 'Avatar',
       description = 'Contact''s avatar',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'avatarUrl'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Avatar';
update core."fieldMetadata" f
   set label = 'Бюджет до',
       description = 'Верхняя граница',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'budgetMax'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Бюджет до';
update core."fieldMetadata" f
   set label = 'Calendar Event Participants',
       description = 'Calendar Event Participants',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventParticipants'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar Event Participants';
update core."fieldMetadata" f
   set label = 'Calendar events',
       description = 'Calendar events tied to the contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar events';
update core."fieldMetadata" f
   set label = 'Объект',
       description = 'Contact''s company',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'company'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Объект';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Район',
       description = 'Где хочет жить',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'district'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Район';
update core."fieldMetadata" f
   set label = 'Почта',
       description = 'Contact''s Emails',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'emails'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Почта';
update core."fieldMetadata" f
   set label = 'Срок покупки',
       description = 'Когда планирует',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'horizon'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Срок покупки';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Должность',
       description = 'Contact''s job title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'jobTitle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Должность';
update core."fieldMetadata" f
   set label = 'Linkedin',
       description = 'Contact''s Linkedin account',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'linkedinLink'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Linkedin';
update core."fieldMetadata" f
   set label = 'Lists',
       description = 'Lists the contact belongs to',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'listMemberships'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Lists';
update core."fieldMetadata" f
   set label = 'Message Participants',
       description = 'Message Participants',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'messageParticipants'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Participants';
update core."fieldMetadata" f
   set label = 'Emails',
       description = 'Message threads tied to the contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'messageThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Emails';
update core."fieldMetadata" f
   set label = 'Мессенджер',
       description = 'Ник в переписке',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'messenger'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Мессенджер';
update core."fieldMetadata" f
   set label = 'Имя',
       description = 'Contact''s name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Имя';
update core."fieldMetadata" f
   set label = 'Заметки',
       description = 'Notes tied to the contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'noteTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Заметки';
update core."fieldMetadata" f
   set label = 'Форма оплаты',
       description = 'Как платит',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'payment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Форма оплаты';
update core."fieldMetadata" f
   set label = 'Телефон',
       description = 'Contact''s phone numbers',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'phones'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Телефон';
update core."fieldMetadata" f
   set label = 'Opportunities',
       description = 'List of opportunities for which that person is the point of contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'pointOfContactForOpportunities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunities';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Person record Position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Цель покупки',
       description = 'Для себя или вложение',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'purpose'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Цель покупки';
update core."fieldMetadata" f
   set label = 'Комнат',
       description = '0 — студия',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'rooms'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Комнат';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Задачи',
       description = 'Tasks tied to the contact',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'taskTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Задачи';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Events linked to the person',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Access level',
       description = 'What the principal may do with the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'accessLevel'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Access level';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Object metadata ID',
       description = 'Object of the shared record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'objectMetadataId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Object metadata ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Record share position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Principal ID',
       description = 'Who receives the access',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'principalId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Principal ID';
update core."fieldMetadata" f
   set label = 'Principal type',
       description = 'Kind of principal receiving the access',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'principalType'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Principal type';
update core."fieldMetadata" f
   set label = 'Record ID',
       description = 'Shared record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'recordId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Record ID';
update core."fieldMetadata" f
   set label = 'Row cause',
       description = 'Why the access was granted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'rowCause'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Row cause';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Source ID',
       description = 'Owner, sharing rule or application that granted the access',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'sourceId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Source ID';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'recordShare'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Исполнитель',
       description = 'Task assignee',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'assignee'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Исполнитель';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Task attachments',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Описание',
       description = 'Task body',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'bodyV2'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Описание';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Срок',
       description = 'Task due date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'dueAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Срок';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Вид задачи',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'kind'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вид задачи';
update core."fieldMetadata" f
   set label = 'Комментарии',
       description = 'Tasks Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'kommentarii'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Комментарии';
update core."fieldMetadata" f
   set label = 'Дата следующего шага',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'nextAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Дата следующего шага';
update core."fieldMetadata" f
   set label = 'Результат',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'outcome'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Результат';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Task record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Важность',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'priority'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Важность';
update core."fieldMetadata" f
   set label = 'Когда делать',
       description = 'День, когда берутся за дело. Просрочкой не считается — в отличие от дедлайна.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'scheduledAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Когда делать';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Срок по SLA',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'slaDueAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Срок по SLA';
update core."fieldMetadata" f
   set label = 'SLA, мин',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'slaMinutes'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'SLA, мин';
update core."fieldMetadata" f
   set label = 'Статус SLA',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'slaStatus'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Статус SLA';
update core."fieldMetadata" f
   set label = 'Переносов',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'snoozeCount'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Переносов';
update core."fieldMetadata" f
   set label = 'Статус',
       description = 'Task status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'status'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Статус';
update core."fieldMetadata" f
   set label = 'Задачи',
       description = 'Task targets',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'taskTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Задачи';
update core."fieldMetadata" f
   set label = 'Команда',
       description = 'Команда исполнителя. Заполняется автоматически — по ней старший брокер видит задачи своих людей.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'team'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Команда';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline Activities linked to the task.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Что сделать',
       description = 'Task title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'title'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Что сделать';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Chats',
       description = 'TaskComments tied to the Agent chat thread target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'agentChatThreadTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Chats';
update core."fieldMetadata" f
   set label = 'Attachments',
       description = 'TaskComments tied to the Attachment',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Attachments';
update core."fieldMetadata" f
   set label = 'Автор',
       description = 'TaskComments tied to the Сотрудник',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'author'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Автор';
update core."fieldMetadata" f
   set label = 'Creation date',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Creation date';
update core."fieldMetadata" f
   set label = 'Created by',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Created by';
update core."fieldMetadata" f
   set label = 'Deleted at',
       description = 'Deletion date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Deleted at';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'Name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Notes',
       description = 'TaskComments tied to the Note Target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'noteTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Notes';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Search vector',
       description = 'Search vector',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Search vector';
update core."fieldMetadata" f
   set label = 'Задача',
       description = 'TaskComments tied to the Задача',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'task'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Задача';
update core."fieldMetadata" f
   set label = 'Tasks',
       description = 'TaskComments tied to the Task Target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'taskTargets'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Tasks';
update core."fieldMetadata" f
   set label = 'Текст',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'text'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Текст';
update core."fieldMetadata" f
   set label = 'Timeline Activities',
       description = 'TaskComments tied to the Timeline Activity',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Timeline Activities';
update core."fieldMetadata" f
   set label = 'Last update',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Last update';
update core."fieldMetadata" f
   set label = 'Updated by',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Updated by';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'TaskTarget record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Company',
       description = 'TaskTarget target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Company';
update core."fieldMetadata" f
   set label = 'Opportunity',
       description = 'TaskTarget target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunity';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'TaskTarget target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'TaskComment',
       description = 'TaskTargets Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTaskComment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'TaskComment';
update core."fieldMetadata" f
   set label = 'Task',
       description = 'TaskTarget task',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'task'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Task';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Creation date',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'happensAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Creation date';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Linked Object Metadata ID',
       description = 'Linked Object Metadata ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'linkedObjectMetadataId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Linked Object Metadata ID';
update core."fieldMetadata" f
   set label = 'Linked Record cached name',
       description = 'Cached record name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'linkedRecordCachedName'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Linked Record cached name';
update core."fieldMetadata" f
   set label = 'Linked Record id',
       description = 'Linked Record id',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'linkedRecordId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Linked Record id';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Timeline activity record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Event details',
       description = 'JSON value for event details',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'properties'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event details';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Company',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetCompany'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Company';
update core."fieldMetadata" f
   set label = 'Dashboard',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetDashboard'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Dashboard';
update core."fieldMetadata" f
   set label = 'MessageCampaign',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetMessageCampaign'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'MessageCampaign';
update core."fieldMetadata" f
   set label = 'MessageList',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetMessageList'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'MessageList';
update core."fieldMetadata" f
   set label = 'Note',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetNote'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Note';
update core."fieldMetadata" f
   set label = 'Opportunity',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetOpportunity'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Opportunity';
update core."fieldMetadata" f
   set label = 'Person',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetPerson'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Person';
update core."fieldMetadata" f
   set label = 'Task',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTask'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Task';
update core."fieldMetadata" f
   set label = 'TaskComment',
       description = 'TimelineActivities Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetTaskComment'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'TaskComment';
update core."fieldMetadata" f
   set label = 'Workflow',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetWorkflow'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow';
update core."fieldMetadata" f
   set label = 'WorkflowRun',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetWorkflowRun'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'WorkflowRun';
update core."fieldMetadata" f
   set label = 'WorkflowVersion',
       description = 'Event target',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'targetWorkflowVersion'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'WorkflowVersion';
update core."fieldMetadata" f
   set label = 'Event type',
       description = 'Timeline activity type describing this event',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivityTypeId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event type';
update core."fieldMetadata" f
   set label = 'Event type',
       description = 'Timeline activity type describing this event',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivityTypeSnapshot'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Event type';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Workspace Member',
       description = 'Event workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where f."objectMetadataId" = o.id
   and f.name = 'workspaceMember'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workspace Member';
update core."fieldMetadata" f
   set label = 'Вложения',
       description = 'Attachments linked to the workflow',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'attachments'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Вложения';
update core."fieldMetadata" f
   set label = 'Automated Triggers',
       description = 'Workflow automated triggers linked to the workflow.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'automatedTriggers'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Automated Triggers';
update core."fieldMetadata" f
   set label = 'Core workflow id',
       description = 'Reference to the core workflow row',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'coreWorkflowId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Core workflow id';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Last published Version ID',
       description = 'The workflow last published version id',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'lastPublishedVersionId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Last published Version ID';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'The workflow name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Workflow record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Runs',
       description = 'Workflow runs linked to the workflow.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'runs'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Runs';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Statuses',
       description = 'The current statuses of the workflow versions',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'statuses'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Statuses';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline activities linked to the workflow',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Versions',
       description = 'Workflow versions linked to the workflow.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where f."objectMetadataId" = o.id
   and f.name = 'versions'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Versions';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'WorkflowAutomatedTrigger record position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Settings',
       description = 'The workflow automated trigger settings',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'settings'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Settings';
update core."fieldMetadata" f
   set label = 'Automated Trigger Type',
       description = 'The workflow automated trigger type',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'type'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Automated Trigger Type';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Workflow',
       description = 'WorkflowAutomatedTrigger workflow',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where f."objectMetadataId" = o.id
   and f.name = 'workflow'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow';
update core."fieldMetadata" f
   set label = 'Core workflow id',
       description = 'Reference to the core workflow row',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'coreWorkflowId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Core workflow id';
update core."fieldMetadata" f
   set label = 'Core workflow version id',
       description = 'Reference to the core workflowVersion row',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'coreWorkflowVersionId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Core workflow version id';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Executed by',
       description = 'The executor of the workflow',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Executed by';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'Workflow run ended at',
       description = 'Workflow run ended at',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'endedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow run ended at';
update core."fieldMetadata" f
   set label = 'Workflow run enqueued at',
       description = 'Workflow run enqueued at',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'enqueuedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow run enqueued at';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'Name of the workflow run',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Workflow run position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Workflow run started at',
       description = 'Workflow run started at',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'startedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow run started at';
update core."fieldMetadata" f
   set label = 'State',
       description = 'State of the workflow run',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'state'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'State';
update core."fieldMetadata" f
   set label = 'Workflow run status',
       description = 'Workflow run status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'status'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow run status';
update core."fieldMetadata" f
   set label = 'Step logs',
       description = 'Per-step observability payload (token usage, tool calls, log entries)',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'stepLogs'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Step logs';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline activities linked to the run',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Workflow',
       description = 'Workflow linked to the run.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'workflow'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow';
update core."fieldMetadata" f
   set label = 'Workflow version',
       description = 'Workflow version linked to the run.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where f."objectMetadataId" = o.id
   and f.name = 'workflowVersion'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow version';
update core."fieldMetadata" f
   set label = 'Core workflow version id',
       description = 'Reference to the core workflowVersion row',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'coreWorkflowVersionId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Core workflow version id';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'The workflow version name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Workflow version position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Runs',
       description = 'Workflow runs linked to the version.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'runs'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Runs';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Version status',
       description = 'The workflow version status',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'status'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Version status';
update core."fieldMetadata" f
   set label = 'Version steps',
       description = 'JSON object to provide steps',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'steps'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Version steps';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Timeline activities linked to the version',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Version trigger',
       description = 'JSON object to provide trigger',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'trigger'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Version trigger';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'Workflow',
       description = 'WorkflowVersion workflow',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where f."objectMetadataId" = o.id
   and f.name = 'workflow'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Workflow';
update core."fieldMetadata" f
   set label = 'Account Owner For Companies',
       description = 'Account owner for companies',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'accountOwnerForCompanies'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Account Owner For Companies';
update core."fieldMetadata" f
   set label = 'Chat threads',
       description = 'AI chat threads owned by the workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'agentChatThreads'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Chat threads';
update core."fieldMetadata" f
   set label = 'Assigned tasks',
       description = 'Tasks assigned to the workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'assignedTasks'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Assigned tasks';
update core."fieldMetadata" f
   set label = 'Avatar URL',
       description = 'Workspace member avatar',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'avatarUrl'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Avatar URL';
update core."fieldMetadata" f
   set label = 'Blocklist',
       description = 'Blocklisted handles',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'blocklist'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Blocklist';
update core."fieldMetadata" f
   set label = 'Calendar Event Participants',
       description = 'Calendar Event Participants',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarEventParticipants'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Calendar Event Participants';
update core."fieldMetadata" f
   set label = 'Start of the week',
       description = 'User''s preferred start day of the week',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'calendarStartDay'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Start of the week';
update core."fieldMetadata" f
   set label = 'Color Scheme',
       description = 'Preferred color scheme',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'colorScheme'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Color Scheme';
update core."fieldMetadata" f
   set label = 'Создана',
       description = 'Creation date',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'createdAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Создана';
update core."fieldMetadata" f
   set label = 'Кем создана',
       description = 'The creator of the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'createdBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем создана';
update core."fieldMetadata" f
   set label = 'Date format',
       description = 'User''s preferred date format',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'dateFormat'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Date format';
update core."fieldMetadata" f
   set label = 'Удалена',
       description = 'Date when the record was deleted',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'deletedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Удалена';
update core."fieldMetadata" f
   set label = 'ID',
       description = 'ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'id'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'ID';
update core."fieldMetadata" f
   set label = 'Job Title',
       description = 'Workspace member job title',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'jobTitle'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Job Title';
update core."fieldMetadata" f
   set label = 'Комментарии к задачам',
       description = 'WorkspaceMembers Комментарий',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'kommentariiKZadacham'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Комментарии к задачам';
update core."fieldMetadata" f
   set label = 'Оператор KulpunAI',
       description = 'Идентификатор оператора в KulpunAI. Связывает сотрудника с его учётной записью в чате.',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'kulpunaiAgentId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Оператор KulpunAI';
update core."fieldMetadata" f
   set label = 'Language',
       description = 'Preferred language',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'locale'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Language';
update core."fieldMetadata" f
   set label = 'Message Participants',
       description = 'Message Participants',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'messageParticipants'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Message Participants';
update core."fieldMetadata" f
   set label = 'Name',
       description = 'Workspace member name',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'name'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Name';
update core."fieldMetadata" f
   set label = 'Number format',
       description = 'User''s preferred number format',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'numberFormat'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Number format';
update core."fieldMetadata" f
   set label = 'Open Records In',
       description = 'Where records open for objects that follow the member''s preference',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'openRecordIn'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Open Records In';
update core."fieldMetadata" f
   set label = 'Owned opportunities',
       description = 'Opportunities owned by the workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'ownedOpportunities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Owned opportunities';
update core."fieldMetadata" f
   set label = 'Position',
       description = 'Workspace member position',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'position'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Position';
update core."fieldMetadata" f
   set label = 'Поиск',
       description = 'Field used for full-text search',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'searchVector'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Поиск';
update core."fieldMetadata" f
   set label = 'Роль в команде',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'seniority'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Роль в команде';
update core."fieldMetadata" f
   set label = 'Команда',
       description = null,
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'team'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Команда';
update core."fieldMetadata" f
   set label = 'Телеграм',
       description = 'Куда боту слать личные уведомления. Заполняется само, когда человек открывает свою ссылку и нажимает «Старт».',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'telegramChatId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Телеграм';
update core."fieldMetadata" f
   set label = 'Time format',
       description = 'User''s preferred time format',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'timeFormat'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Time format';
update core."fieldMetadata" f
   set label = 'История',
       description = 'Events linked to the workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'timelineActivities'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'История';
update core."fieldMetadata" f
   set label = 'Time zone',
       description = 'User time zone',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'timeZone'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Time zone';
update core."fieldMetadata" f
   set label = 'Interface Scale',
       description = 'Preferred interface scale',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'uiScale'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Interface Scale';
update core."fieldMetadata" f
   set label = 'Изменена',
       description = 'Last time the record was changed',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedAt'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Изменена';
update core."fieldMetadata" f
   set label = 'Кем изменена',
       description = 'The workspace member who last updated the record',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'updatedBy'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'Кем изменена';
update core."fieldMetadata" f
   set label = 'User Email',
       description = 'Related user email address',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'userEmail'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'User Email';
update core."fieldMetadata" f
   set label = 'User ID',
       description = 'Associated User ID',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where f."objectMetadataId" = o.id
   and f.name = 'userId'
   and w."databaseSchema" = '__WS__'
   and f.label is distinct from 'User ID';

-- ── Названия видов ───────────────────────────────────────────────
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'attachment'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'blocklist'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarChannelEventAssociation'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEvent'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'calendarEventParticipant'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'callRecording'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'company'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'dashboard'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'message'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageCampaign'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociation'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageChannelMessageAssociationMessageFolder'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageList'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageListMember'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageParticipant'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'messageThread'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'note'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'noteTarget'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'Воронка', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'Воронка';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'person'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskComment'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'taskTarget'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'timelineActivity'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflow'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'All {objectLabelPlural}', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowAutomatedTrigger'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'All {objectLabelPlural}';
update core.view v
   set name = 'Runs', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowRun'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'Runs';
update core.view v
   set name = 'Versions', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workflowVersion'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'Versions';
update core.view v
   set name = 'Вся команда', "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'workspaceMember'
 where v."objectMetadataId" = o.id
   and v.key::text = 'INDEX'
   and v."deletedAt" is null
   and w."databaseSchema" = '__WS__'
   and v.name is distinct from 'Вся команда';
