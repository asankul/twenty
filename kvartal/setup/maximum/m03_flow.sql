-- Движок воронки Maximum English.
--
-- Заменяет карту переходов, снятую с Квартала: там недвижимость, здесь
-- школа. Механика та же — исход закрывает задачу, двигает статус и
-- рождает следующую, — меняется только содержимое карты.
--
-- Карта собрана по схеме из коммерческого предложения, стрелка в стрелку.

-- ── Вес задачи ───────────────────────────────────────────────────────
-- Чем дороже промедление, тем выше в очереди. Пробное стоит дороже
-- всего: там человек физически придёт в филиал и будет ждать.
create or replace function ops.task_weight(kind text) returns double precision as $w$
  select case kind
    when 'TRIAL'   then 100   -- занятие назначено, человек придёт
    when 'BRANCH'  then  90   -- клиент в филиале, деньги на столе
    when 'PAYMENT' then  90
    when 'CLOSING' then  80   -- после пробного, решение висит на волоске
    when 'GROUP'   then  70   -- набор группы, сроки длиннее
    when 'CALL'    then  60   -- обычный звонок
    else                 30   -- своя задача: поставил сам, сам и решает
  end;
$w$ language sql;

-- ── Переходы ─────────────────────────────────────────────────────────
create or replace function ops.task_outcome_apply() returns trigger as $f$
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
  tries int;
  cold boolean := false;
begin
  if new.outcome is null or new.outcome is not distinct from old.outcome then
    return null;
  end if;

  select tt."targetOpportunityId", o.stage::text, nullif(trim(o.name), '')
    into oid, cur, who
    from __WS__."taskTarget" tt
    join __WS__.opportunity o on o.id = tt."targetOpportunityId"
   where tt."taskId" = new.id and tt."deletedAt" is null
   limit 1;

  if oid is null then
    return null;   -- задача сама по себе, двигать нечего
  end if;

  case new.outcome

    -- Звонок ---------------------------------------------------------
    when 'NO_ANSWER' then
      -- Три попытки, потом вниз очереди. Считаем по закрытым звонкам
      -- этого же клиента, а не по счётчику на задаче: задачи сменяются,
      -- а история остаётся.
      select count(*) into tries
        from __WS__."taskTarget" tt
        join __WS__.task t on t.id = tt."taskId"
       where tt."targetOpportunityId" = oid
         and tt."deletedAt" is null and t."deletedAt" is null
         and t.outcome::text = 'NO_ANSWER';

      next_kind := 'CALL'; next_title := 'Позвонить';
      if tries >= 3 then
        want := 'NO_ANSWER';            -- статус «Недозвон»
        next_due := interval '1 day';
        cold := true;                   -- и вниз очереди
      else
        want := null;
        next_due := interval '3 hours';
      end if;

    when 'REACHED_SOLO' then
      want := 'TRIAL_BOOKED'; next_kind := 'BRANCH';
      next_title := 'Принять в филиале'; next_due := interval '1 day';

    when 'REACHED_GROUP' then
      want := 'QUALIFIED'; next_kind := 'GROUP';
      next_title := 'Подобрать группу'; next_due := interval '1 day';

    -- Подбор группы --------------------------------------------------
    when 'GROUP_FOUND' then
      want := 'TRIAL_BOOKED'; next_kind := 'BRANCH';
      next_title := 'Принять в филиале'; next_due := interval '1 day';

    when 'GROUP_NONE' then
      want := 'RECRUITING'; next_kind := 'GROUP';
      next_title := 'Проверить набор'; next_due := interval '7 days';

    when 'GROUP_READY' then
      want := 'TRIAL_SET'; next_kind := 'TRIAL';
      next_title := 'Провести пробное'; next_due := interval '1 day';

    when 'GROUP_FAILED' then
      want := 'IN_WORK'; next_kind := 'CALL';
      next_title := 'Позвонить'; next_due := interval '1 day';

    -- Филиал и оплата ------------------------------------------------
    when 'PAID' then
      want := 'TRIAL_SET'; next_kind := 'TRIAL';
      next_title := 'Провести пробное'; next_due := interval '1 day';

    when 'NOT_PAID' then
      want := 'UNPAID'; next_kind := 'PAYMENT';
      next_title := 'Дождаться оплаты'; next_due := interval '1 day';

    when 'WAITING_PAYMENT' then
      want := null; next_kind := 'PAYMENT';
      next_title := 'Дождаться оплаты'; next_due := interval '2 days';

    -- Пробное занятие ------------------------------------------------
    when 'TRIAL_PAID' then
      want := 'STUDENT'; next_kind := null; next_title := null; next_due := null;

    when 'TRIAL_THINKING' then
      want := 'CLOSING'; next_kind := 'CLOSING';
      next_title := 'Дожать после пробного'; next_due := interval '2 days';

    when 'TRIAL_NOSHOW' then
      want := 'NO_SHOW'; next_kind := 'CALL';
      next_title := 'Позвонить после неявки'; next_due := interval '1 day';

    when 'RESCHEDULED' then
      want := 'TRIAL_SET'; next_kind := 'TRIAL';
      next_title := 'Провести пробное'; next_due := interval '1 day';

    when 'NOSHOW_AGAIN' then
      want := 'LOST'; next_kind := null; next_title := null; next_due := null;

    -- Дожим ----------------------------------------------------------
    when 'CLOSED_PAID' then
      want := 'STUDENT'; next_kind := null; next_title := null; next_due := null;

    -- Выходы ---------------------------------------------------------
    when 'REFUSED' then
      want := 'LOST'; next_kind := null; next_title := null; next_due := null;

    when 'COMPLETED' then
      want := null; next_kind := null; next_title := null; next_due := null;

    when 'DROPPED' then
      want := null; next_kind := null; next_title := null; next_due := null;

    else
      want := null; next_kind := null; next_title := null; next_due := null;
  end case;

  -- Статус двигаем, только если он действительно меняется. Назад по
  -- воронке не откатываем, кроме явных возвратов — неявки и развала
  -- группы: это честные шаги назад, они описаны в схеме.
  if want is not null and cur <> 'STUDENT' and want <> cur then
    update __WS__.opportunity
       set stage = want::__WS__.opportunity_stage_enum,
           "updatedAt" = now()
     where id = oid;
  end if;

  if next_title is null then
    return null;
  end if;

  -- Дату может назвать сам менеджер: «перезвонить в четверг».
  if new."nextAt" is not null and new."nextAt" > now() then
    next_at := new."nextAt";
  else
    next_at := now() + next_due;
  end if;

  if who is not null then
    next_title := next_title || ' — ' || who;
  end if;

  tid := gen_random_uuid();

  insert into __WS__.task
    (id, title, status, kind, "assigneeId", team, "dueAt", "scheduledAt",
     "slaMinutes", "slaDueAt", "slaStatus",
     "createdAt", "updatedAt", "createdBySource", "createdByName", position)
  values
    (tid, next_title, 'TODO', next_kind::__WS__."task_kind_enum",
     new."assigneeId", new.team, next_at, next_at,
     round(extract(epoch from (next_at - now())) / 60), next_at, 'ON_TIME',
     now(), now(), 'SYSTEM', 'Авто', 0);

  insert into __WS__."taskTarget"
    (id, "taskId", "targetOpportunityId", "createdAt", "updatedAt", position)
  values (gen_random_uuid(), tid, oid, now(), now(), 0);

  -- После третьего недозвона задача уходит вниз очереди. Вес правим
  -- отдельным запросом: ops.task_set_priority срабатывает на вставку и
  -- на смену вида, а простое изменение веса его не будит.
  if cold then
    update __WS__.task set priority = 20 where id = tid;
  end if;

  return null;
end;
$f$ language plpgsql;
