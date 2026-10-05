-- Свои пункты бокового меню.
--
-- Снято с живой базы Квартала скриптом extract_look.py.
--
-- Переносим только ссылки на наши страницы. Пункты типа OBJECT Twenty
-- заводит сам при создании кабинета, а RECORD — это личные закладки
-- конкретных людей, в другом кабинете им делать нечего.

-- ── Пункты меню ──────────────────────────────────────────────────
insert into core."navigationMenuItem"
  (id, name, type, link, position, icon, color, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Моя работа', 'LINK', '/work', -1,
       'IconTargetArrow', null, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."navigationMenuItem" n
                    where n."workspaceId" = w.id and n.link = '/work');
insert into core."navigationMenuItem"
  (id, name, type, link, position, icon, color, "workspaceId", "applicationId",
   "universalIdentifier", "createdAt", "updatedAt")
select gen_random_uuid(), 'Структура отдела', 'LINK', '/team-structure', 3,
       'IconHierarchy2', null, w.id, w."workspaceCustomApplicationId",
       gen_random_uuid(), now(), now()
  from core.workspace w
 where w."databaseSchema" = '__WS__'
   and not exists (select 1 from core."navigationMenuItem" n
                    where n."workspaceId" = w.id and n.link = '/team-structure');
