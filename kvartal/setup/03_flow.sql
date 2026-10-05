-- Флоу сделки: веса, нормативы, исходы задач.
--
-- Снято с боевой базы Квартала скриптом extract.sh, не написано по памяти.
-- Имя схемы кабинета подставляет install.sh вместо __WS__.
--
-- ВАЖНО: функции живут в общей схеме ops, а имя схемы кабинета вшито в их
-- тела. Два кабинета в одной базе затрут функции друг друга. Поэтому у
-- каждого кабинета должна быть своя база.
--
-- Ставится поверх созданного кабинета, когда поля и стадии уже на месте.
-- Повторный прогон безопасен.

create schema if not exists ops;

CREATE OR REPLACE FUNCTION ops.task_weight(kind text)
 RETURNS double precision
 LANGUAGE sql
 IMMUTABLE
AS $function$
  select case kind
    when 'SHOWING'     then 100
    when 'CONTRACT'    then  90
    when 'PAYMENT'     then  90
    when 'FOLLOWUP'    then  70
    when 'FIRST_TOUCH' then  50
    else 30
  end;
$function$
;

CREATE OR REPLACE FUNCTION ops.opportunity_priority_from_target()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  perform ops.opportunity_priority_refresh(new."targetOpportunityId");
  if tg_op <> 'INSERT' then
    perform ops.opportunity_priority_refresh(old."targetOpportunityId");
  end if;
  return null;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.opportunity_priority_from_task()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
  oid uuid;
begin
  for oid in
    select distinct tt."targetOpportunityId"
      from __WS__."taskTarget" tt
     where tt."taskId" = coalesce(new.id, old.id)
       and tt."targetOpportunityId" is not null
  loop
    perform ops.opportunity_priority_refresh(oid);
  end loop;
  return null;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.opportunity_priority_refresh(oid uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
  if oid is null then return; end if;
  update __WS__.opportunity
     set priority = ops.opportunity_weight(oid)
   where id = oid
     and priority is distinct from ops.opportunity_weight(oid);
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.opportunity_weight(oid uuid)
 RETURNS integer
 LANGUAGE sql
 STABLE
AS $function$
  select coalesce(max(t.priority), 0)
    from __WS__."taskTarget" tt
    join __WS__.task t on t.id = tt."taskId"
   where tt."targetOpportunityId" = oid
     and tt."deletedAt" is null
     and t."deletedAt" is null
     and t.status::text in ('TODO', 'IN_PROGRESS');
$function$
;

CREATE OR REPLACE FUNCTION ops.task_done_needs_outcome()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  if new.status = $$DONE$$
     and (old.status is null or old.status::text not in ($$DONE$$, $$CANCELLED$$))
     and new.outcome is null
     and coalesce(new.kind::text, $$MANUAL$$) <> $$MANUAL$$ then
    raise exception $$Задачу нельзя закрыть галочкой — выберите итог, иначе сделка не сдвинется$$;
  end if;
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.task_follow_owner()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  if new."ownerId" is distinct from old."ownerId" and new."ownerId" is not null then
    update __WS__.task t
       set "assigneeId" = new."ownerId",
           team = (select m.team::text::__WS__.task_team_enum
                     from __WS__."workspaceMember" m
                    where m.id = new."ownerId"),
           "updatedAt" = now()
      from __WS__."taskTarget" tt
     where tt."taskId" = t.id
       and tt."targetOpportunityId" = new.id
       and tt."deletedAt" is null
       and t."deletedAt" is null
       and t.status in ('TODO', 'IN_PROGRESS');
  end if;
  return null;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.task_outcome_apply()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
  oid uuid;
  cur text;
  who text;
  want text;
  next_title text;
  next_kind text;
  next_due interval;
  next_at timestamptz;
  tid uuid;
  -- Порядок активной воронки. Отложен, отказ и «не наш» в него не входят:
  -- это выходы, а не ступени.
  ladder text[] := array['NEW','CONTACTED','QUALIFIED','MEETING',
                         'BOOKED','CONTRACT','CLOSED_WON'];
begin
  if new.outcome is null or new.outcome is not distinct from old.outcome then
    return null;
  end if;

  select tt."targetOpportunityId", o.stage::text, nullif(trim(o.name), '')
    into oid, cur, who
    from __WS__."taskTarget" tt
    join __WS__.opportunity o
      on o.id = tt."targetOpportunityId"
   where tt."taskId" = new.id and tt."deletedAt" is null
   limit 1;

  if oid is null then
    return null;   -- задача сама по себе, двигать нечего
  end if;

  case new.outcome
    when 'NO_ANSWER' then
      want := null;         next_kind := 'FOLLOWUP'; next_title := 'Перезвонить';
      next_due := interval '3 hours';
    when 'THINKING' then
      want := 'QUALIFIED';  next_kind := 'FOLLOWUP'; next_title := 'Перезвонить';
      next_due := interval '2 days';
    when 'POSTPONED' then
      want := 'NURTURE';    next_kind := 'FOLLOWUP'; next_title := 'Вернуться к клиенту';
      next_due := interval '30 days';
    when 'SHOWING_SET' then
      want := 'MEETING';    next_kind := 'SHOWING';  next_title := 'Провести показ';
      next_due := interval '1 day';
    when 'NO_SHOW' then
      want := 'QUALIFIED';  next_kind := 'FOLLOWUP'; next_title := 'Перезвонить';
      next_due := interval '1 day';
    when 'RESCHEDULED' then
      want := null;         next_kind := 'SHOWING';  next_title := 'Провести показ';
      next_due := interval '1 day';
    when 'BOOKED' then
      want := 'BOOKED';     next_kind := 'CONTRACT'; next_title := 'Подписать договор';
      next_due := interval '3 days';
    when 'CONTRACT_SIGNED' then
      want := 'CONTRACT';   next_kind := 'PAYMENT';  next_title := 'Довести до оплаты';
      next_due := interval '7 days';
    when 'DELAYED' then
      -- Тот же шаг, только позже: вид и название берём у текущей задачи.
      want := null;         next_kind := coalesce(new.kind::text, 'FOLLOWUP');
      next_title := split_part(coalesce(new.title, 'Напомнить'), ' — ', 1);
      next_due := case when new.kind::text = 'CONTRACT'
                       then interval '2 days' else interval '3 days' end;
    when 'PAID' then
      want := 'CLOSED_WON'; next_kind := null; next_title := null; next_due := null;
    when 'REFUSED' then
      want := 'IRRELEVANT'; next_kind := null; next_title := null; next_due := null;
    when 'NOT_OURS' then
      want := 'UNQUALIFIED'; next_kind := null; next_title := null; next_due := null;
    when 'COMPLETED' then
      want := null; next_kind := null; next_title := null; next_due := null;
    when 'DROPPED' then
      want := null; next_kind := null; next_title := null; next_due := null;
  end case;

  -- Стадию двигаем, если она действительно изменилась. Назад по активной
  -- воронке не откатываем — кроме «не пришёл», это честный возврат со встречи.
  if want is not null and cur <> 'CLOSED_WON' and want <> cur then
    if want not in ('QUALIFIED')
       or new.outcome = 'NO_SHOW'
       or array_position(ladder, cur) is null
       or array_position(ladder, cur) < array_position(ladder, want)
    then
      update __WS__.opportunity
         set stage = want::__WS__.opportunity_stage_enum,
             "updatedAt" = now()
       where id = oid;
    end if;
  end if;

  if next_title is null then
    return null;
  end if;

  -- Дату может назвать сам брокер: «показ в субботу», «вернуться в марте».
  if new."nextAt" is not null and new."nextAt" > now() then
    next_at := new."nextAt";
  else
    next_at := now() + next_due;
  end if;

  -- Имя клиента в названии: на карточке оно и так сверху, а в общем списке
  -- задач без него двадцать одинаковых строк «Перезвонить».
  if who is not null then
    next_title := next_title || ' — ' || who;
  end if;

  tid := gen_random_uuid();

  insert into __WS__.task
    (id, title, status, kind, "assigneeId", team, "dueAt", "scheduledAt",
     "slaMinutes", "slaDueAt", "slaStatus",
     "createdAt", "updatedAt", "createdBySource", "createdByName", position)
  values
    (tid, next_title, 'TODO',
     next_kind::__WS__."task_kind_enum",
     new."assigneeId", new.team, next_at, next_at,
     round(extract(epoch from (next_at - now())) / 60), next_at, 'ON_TIME',
     now(), now(), 'SYSTEM', 'Авто', 0);

  insert into __WS__."taskTarget"
    (id, "taskId", "targetOpportunityId", "createdAt", "updatedAt", position)
  values (gen_random_uuid(), tid, oid, now(), now(), 0);

  return null;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.task_outcome_guard()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
  has_lead boolean;
  reason text;
begin
  if new.outcome is null or new.outcome is not distinct from old.outcome then
    return new;
  end if;

  -- Отказ без причины не принимаем: иначе через месяц никто не вспомнит,
  -- почему клиент ушёл.
  if new.outcome = 'REFUSED' then
    select true, nullif(trim(o."lostReason"), '') into has_lead, reason
      from __WS__."taskTarget" tt
      join __WS__.opportunity o
        on o.id = tt."targetOpportunityId"
     where tt."taskId" = new.id and tt."deletedAt" is null
     limit 1;

    -- Задача без заявки причину хранить негде: там отказ принимаем как есть.
    if has_lead is true and reason is null then
      new.outcome := old.outcome;
      return new;
    end if;
  end if;

  new.status := (case when new.outcome = 'DROPPED' then 'CANCELLED' else 'DONE' end)
                ::__WS__.task_status_enum;
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.task_set_priority()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.priority := ops.task_weight(new.kind::text);
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.task_sla_default()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  if new.kind is null then
    new.kind := 'MANUAL'::__WS__."task_kind_enum";
  end if;

  -- Без срока задача невидима для сторожа и тонет в конце очереди.
  -- Конец завтрашнего дня — мягкий срок, который человек может подвинуть.
  if new."dueAt" is null then
    new."dueAt" := date_trunc('day', now()) + interval '1 day 18 hours';
  end if;

  if new."slaDueAt" is null then
    new."slaDueAt" := new."dueAt";
  end if;

  if new."slaMinutes" is null then
    new."slaMinutes" := greatest(
      round(extract(epoch from (new."slaDueAt" - now())) / 60), 0);
  end if;

  if new."slaStatus" is null then
    new."slaStatus" := (case when new."slaDueAt" >= now() then 'ON_TIME' else 'LATE' end)
                       ::__WS__."task_slaStatus_enum";
  end if;

  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION ops.task_snooze_count()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  if new."scheduledAt" is distinct from old."scheduledAt"
     and new."scheduledAt" > now()
     and (old."scheduledAt" is null or new."scheduledAt" > old."scheduledAt")
     and new.status in ('TODO', 'IN_PROGRESS')
  then
    new."snoozeCount" := coalesce(old."snoozeCount", 0) + 1;
  end if;
  return new;
end;
$function$
;

drop trigger if exists task_follow_owner on __WS__.opportunity;
CREATE TRIGGER task_follow_owner AFTER UPDATE OF "ownerId" ON __WS__.opportunity FOR EACH ROW EXECUTE FUNCTION ops.task_follow_owner();

drop trigger if exists opportunity_priority_from_task on __WS__.task;
CREATE TRIGGER opportunity_priority_from_task AFTER INSERT OR UPDATE OF kind, status, "deletedAt" ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.opportunity_priority_from_task();

drop trigger if exists task_done_needs_outcome on __WS__.task;
CREATE TRIGGER task_done_needs_outcome BEFORE UPDATE OF status ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.task_done_needs_outcome();

drop trigger if exists task_outcome_apply on __WS__.task;
CREATE TRIGGER task_outcome_apply AFTER UPDATE OF outcome ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.task_outcome_apply();

drop trigger if exists task_outcome_guard on __WS__.task;
CREATE TRIGGER task_outcome_guard BEFORE UPDATE OF outcome ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.task_outcome_guard();

drop trigger if exists task_set_priority on __WS__.task;
CREATE TRIGGER task_set_priority BEFORE INSERT OR UPDATE OF kind ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.task_set_priority();

drop trigger if exists task_sla_default on __WS__.task;
CREATE TRIGGER task_sla_default BEFORE INSERT ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.task_sla_default();

drop trigger if exists task_snooze_count on __WS__.task;
CREATE TRIGGER task_snooze_count BEFORE UPDATE OF "scheduledAt" ON __WS__.task FOR EACH ROW EXECUTE FUNCTION ops.task_snooze_count();

drop trigger if exists opportunity_priority_from_target on __WS__."taskTarget";
CREATE TRIGGER opportunity_priority_from_target AFTER INSERT OR UPDATE OF "targetOpportunityId", "deletedAt" ON __WS__."taskTarget" FOR EACH ROW EXECUTE FUNCTION ops.opportunity_priority_from_target();
