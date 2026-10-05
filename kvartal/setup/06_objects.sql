-- Названия и значки объектов.
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

-- ── Названия ─────────────────────────────────────────────────────
update core."objectMetadata" o
   set "labelSingular" = 'Объект',
       "labelPlural" = 'Застройщики и ЖК',
       icon = 'IconBuildingSkyscraper',
       description = 'Жилые комплексы и компании',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = 'company';
update core."objectMetadata" o
   set "labelSingular" = 'Заметка',
       "labelPlural" = 'Заметки',
       icon = 'IconNotes',
       description = 'История и комментарии',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = 'note';
update core."objectMetadata" o
   set "labelSingular" = 'Лид',
       "labelPlural" = 'Лиды',
       icon = 'IconInbox',
       description = 'Обращения клиентов',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = 'opportunity';
update core."objectMetadata" o
   set "labelSingular" = 'Клиент',
       "labelPlural" = 'Клиенты',
       icon = 'IconUsers',
       description = 'Люди, с которыми работаем',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = 'person';
update core."objectMetadata" o
   set "labelSingular" = 'Задача',
       "labelPlural" = 'Задачи',
       icon = 'IconCheckbox',
       description = 'Следующие шаги по заявкам',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = 'task';
update core."objectMetadata" o
   set "labelSingular" = 'Сотрудник',
       "labelPlural" = 'Моя команда',
       icon = 'IconUserCircle',
       description = 'A workspace member',
       "isLabelSyncedWithName" = false,
       "updatedAt" = now()
  from core.workspace w
 where o."workspaceId" = w.id
   and w."databaseSchema" = '__WS__'
   and o."nameSingular" = 'workspaceMember';
