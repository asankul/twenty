-- Снос демонстрационных записей, которые Twenty засевает в новый кабинет.
--
-- При создании кабинета Twenty кладёт в него витрину: Airbnb, Anthropic,
-- Stripe, Figma, Notion, их сотрудников и выдуманные сделки. В рабочем
-- кабинете это мусор, который путает людей с первого же экрана.
--
-- Отличаются они по подписи автора: у витрины createdByName = 'System'.
-- Наш приёмник пишет 'KulpunAI', триггер исходов — 'Авто', люди — своё
-- имя. Поэтому совпадение точное и ничего живого не заденет.
--
-- Удаляем мягко: записи уходят в корзину, откуда их видно и можно
-- вернуть, если вдруг ошиблись.

update __WS__.opportunity
   set "deletedAt" = now(), "updatedAt" = now()
 where "deletedAt" is null
   and "createdBySource"::text = 'SYSTEM'
   and "createdByName" = 'System';

update __WS__.person
   set "deletedAt" = now(), "updatedAt" = now()
 where "deletedAt" is null
   and "createdBySource"::text = 'SYSTEM'
   and "createdByName" = 'System';

update __WS__.company
   set "deletedAt" = now(), "updatedAt" = now()
 where "deletedAt" is null
   and "createdBySource"::text = 'SYSTEM'
   and "createdByName" = 'System';

update __WS__.note
   set "deletedAt" = now(), "updatedAt" = now()
 where "deletedAt" is null
   and "createdBySource"::text = 'SYSTEM'
   and "createdByName" = 'System';
