-- Поля Maximum English вместо квартальных.
--
-- Квартальные поля не удаляем, а гасим: isActive = false. Данные
-- остаются, поле пропадает из интерфейса, и если что — включается
-- обратно одним запросом. Удалять метаданные вместе с колонкой опаснее
-- и необратимо.
--
-- Филиал заведён списком с одним значением: настоящий список филиалов
-- заказчик ещё не прислал. Добавить значения — одна правка options.

-- ── Гасим квартальные поля ───────────────────────────────────────────
update core."fieldMetadata" f
   set "isActive" = false, "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id
 where f."objectMetadataId" = o.id
   and w."databaseSchema" = '__WS__'
   and (
     (o."nameSingular" = 'opportunity' and f.name in ('rooms', 'district'))
     or
     (o."nameSingular" = 'person' and f.name in ('rooms', 'district', 'horizon', 'purpose', 'payment'))
   );

-- ── Перечисления под новые поля ──────────────────────────────────────
do $e$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_branch_enum') then
    create type __WS__."opportunity_branch_enum" as enum ('UNSET');
  end if;
end $e$;

do $e$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_level_enum') then
    create type __WS__."opportunity_level_enum" as enum
      ('UNKNOWN', 'A1', 'A2', 'B1', 'B2', 'C1');
  end if;
end $e$;

do $e$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_format_enum') then
    create type __WS__."opportunity_format_enum" as enum ('GROUP', 'SOLO');
  end if;
end $e$;

do $e$ begin
  if not exists (select 1 from pg_type t join pg_namespace n on n.oid = t.typnamespace
                  where n.nspname = '__WS__' and t.typname = 'opportunity_mode_enum') then
    create type __WS__."opportunity_mode_enum" as enum ('OFFLINE', 'ONLINE');
  end if;
end $e$;

-- ── Колонки ──────────────────────────────────────────────────────────
alter table __WS__.opportunity add column if not exists branch   __WS__."opportunity_branch_enum";
alter table __WS__.opportunity add column if not exists level    __WS__."opportunity_level_enum";
alter table __WS__.opportunity add column if not exists format   __WS__."opportunity_format_enum";
alter table __WS__.opportunity add column if not exists mode     __WS__."opportunity_mode_enum";
alter table __WS__.opportunity add column if not exists schedule text;
alter table __WS__.opportunity add column if not exists "returnAt" timestamp with time zone;
alter table __WS__.opportunity add column if not exists "trialAt"  timestamp with time zone;
