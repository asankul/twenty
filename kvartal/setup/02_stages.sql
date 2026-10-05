-- Стадии воронки.
--
-- stage — стандартное поле Twenty, мы заменяем у него список значений.
-- Собрано с живой базы Квартала, имя схемы подставляет install.sh.
--
-- Старые значения Twenty из типа не удаляем: убрать значение перечисления
-- в Postgres нельзя, а мешать они не будут — интерфейс показывает только
-- то, что перечислено в options.
--
-- ALTER TYPE ... ADD VALUE внутри транзакции разрешён с Postgres 12,
-- нельзя лишь пользоваться новым значением до коммита. Записей в новом
-- кабинете нет, так что это не мешает.

-- ── Значения типа ────────────────────────────────────────────────
alter type __WS__."opportunity_stage_enum" add value if not exists 'NEW';
alter type __WS__."opportunity_stage_enum" add value if not exists 'CONTACTED';
alter type __WS__."opportunity_stage_enum" add value if not exists 'QUALIFIED';
alter type __WS__."opportunity_stage_enum" add value if not exists 'MEETING';
alter type __WS__."opportunity_stage_enum" add value if not exists 'BOOKED';
alter type __WS__."opportunity_stage_enum" add value if not exists 'CONTRACT';
alter type __WS__."opportunity_stage_enum" add value if not exists 'CLOSED_WON';
alter type __WS__."opportunity_stage_enum" add value if not exists 'NURTURE';
alter type __WS__."opportunity_stage_enum" add value if not exists 'IRRELEVANT';
alter type __WS__."opportunity_stage_enum" add value if not exists 'UNQUALIFIED';

-- ── Список в метаданных ──────────────────────────────────────────
update core."fieldMetadata" f
   set options = '[{"value": "NEW", "label": "Необработанные", "color": "gray", "position": 0}, {"value": "CONTACTED", "label": "Первый контакт", "color": "sky", "position": 1}, {"value": "QUALIFIED", "label": "Квалифицированные", "color": "turquoise", "position": 2}, {"value": "MEETING", "label": "Назначена встреча", "color": "blue", "position": 3}, {"value": "BOOKED", "label": "Бронь", "color": "purple", "position": 4}, {"value": "CONTRACT", "label": "Договор", "color": "yellow", "position": 5}, {"value": "CLOSED_WON", "label": "Оплачено", "color": "green", "position": 6}, {"value": "NURTURE", "label": "Отложен", "color": "orange", "position": 7}, {"value": "IRRELEVANT", "label": "Отказ", "color": "red", "position": 8}, {"value": "UNQUALIFIED", "label": "Не наш", "color": "gray", "position": 9}]'::jsonb,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id
   and f.name = 'stage'
   and w."databaseSchema" = '__WS__';
