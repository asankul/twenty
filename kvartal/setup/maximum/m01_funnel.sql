-- Воронка Maximum English: 13 статусов, виды задач, исходы.
--
-- Собрано по коммерческому предложению школы, не скопировано с Квартала.
-- Квартальная воронка про недвижимость здесь не подходит совсем: там
-- показ квартиры и бронь, здесь пробное занятие и набор группы.
--
-- Имя схемы подставляется вместо __WS__.
--
-- Старые значения из типов не убираем — в Postgres значение перечисления
-- удалить нельзя. Мешать они не будут: интерфейс показывает только то,
-- что перечислено в options.
--
-- ALTER TYPE ... ADD VALUE внутри транзакции разрешён с Postgres 12;
-- нельзя лишь пользоваться новым значением до коммита. Записей в воронке
-- ноль, так что это не мешает.

-- ── Статусы сделки ───────────────────────────────────────────────────
alter type __WS__."opportunity_stage_enum" add value if not exists 'IN_WORK';
alter type __WS__."opportunity_stage_enum" add value if not exists 'NO_ANSWER';
alter type __WS__."opportunity_stage_enum" add value if not exists 'RECRUITING';
alter type __WS__."opportunity_stage_enum" add value if not exists 'TRIAL_BOOKED';
alter type __WS__."opportunity_stage_enum" add value if not exists 'AT_BRANCH';
alter type __WS__."opportunity_stage_enum" add value if not exists 'UNPAID';
alter type __WS__."opportunity_stage_enum" add value if not exists 'TRIAL_SET';
alter type __WS__."opportunity_stage_enum" add value if not exists 'NO_SHOW';
alter type __WS__."opportunity_stage_enum" add value if not exists 'CLOSING';
alter type __WS__."opportunity_stage_enum" add value if not exists 'STUDENT';
alter type __WS__."opportunity_stage_enum" add value if not exists 'LOST';

-- ── Виды задач ───────────────────────────────────────────────────────
-- От вида зависит, какие кнопки видит лид-менеджер.
alter type __WS__."task_kind_enum" add value if not exists 'CALL';
alter type __WS__."task_kind_enum" add value if not exists 'GROUP';
alter type __WS__."task_kind_enum" add value if not exists 'BRANCH';
alter type __WS__."task_kind_enum" add value if not exists 'TRIAL';
alter type __WS__."task_kind_enum" add value if not exists 'CLOSING';

-- ── Исходы ───────────────────────────────────────────────────────────
alter type __WS__."task_outcome_enum" add value if not exists 'REACHED_SOLO';
alter type __WS__."task_outcome_enum" add value if not exists 'REACHED_GROUP';
alter type __WS__."task_outcome_enum" add value if not exists 'GROUP_FOUND';
alter type __WS__."task_outcome_enum" add value if not exists 'GROUP_NONE';
alter type __WS__."task_outcome_enum" add value if not exists 'GROUP_READY';
alter type __WS__."task_outcome_enum" add value if not exists 'GROUP_FAILED';
alter type __WS__."task_outcome_enum" add value if not exists 'NOT_PAID';
alter type __WS__."task_outcome_enum" add value if not exists 'WAITING_PAYMENT';
alter type __WS__."task_outcome_enum" add value if not exists 'TRIAL_PAID';
alter type __WS__."task_outcome_enum" add value if not exists 'TRIAL_THINKING';
alter type __WS__."task_outcome_enum" add value if not exists 'TRIAL_NOSHOW';
alter type __WS__."task_outcome_enum" add value if not exists 'NOSHOW_AGAIN';
alter type __WS__."task_outcome_enum" add value if not exists 'CLOSED_PAID';
