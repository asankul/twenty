import { styled } from '@linaria/react';
import type React from 'react';
import { useMemo, useState } from 'react';
import { themeCssVariables } from 'twenty-ui/theme';

import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { useAtomStateValue } from '@/ui/utilities/state/jotai/hooks/useAtomStateValue';

/**
 * Очередь: одна задача на экране.
 *
 * Отдел — продажники, не пользователи CRM. Список из двадцати строк, меню
 * и вкладки они не читают: заходят, не находят, чем заняться, и уходят
 * обратно в чат. Поэтому здесь нет ни списка, ни навигации — только та
 * задача, которую надо сделать прямо сейчас, и чем она заканчивается.
 *
 * Выход из карточки один: выбрать результат или отложить с указанием срока.
 * Отложить — полноценное действие, а не лазейка: клиент спит, за рулём,
 * просил набрать вечером. Без этой кнопки её роль возьмёт на себя случайно
 * нажатый результат, и данные станут хуже, чем были.
 *
 * Стадию лида и следующий шаг ставит триггер в базе, здесь только выбор.
 */

type Member = {
  id: string;
  name?: { firstName?: string | null; lastName?: string | null } | null;
};

type Task = {
  __typename: string;
  id: string;
  title?: string | null;
  status?: string | null;
  outcome?: string | null;
  dueAt?: string | null;
  scheduledAt?: string | null;
  updatedAt?: string | null;
  snoozeCount?: number | null;
  assigneeId?: string | null;
};

type TaskTarget = {
  __typename: string;
  id: string;
  taskId?: string | null;
  targetOpportunityId?: string | null;
};

type Lead = {
  __typename: string;
  id: string;
  name?: string | null;
  channel?: string | null;
  district?: string | null;
  rooms?: number | null;
  comment?: string | null;
  lostReason?: string | null;
  createdAt?: string | null;
  budgetMax?: { amountMicros?: number | null; currencyCode?: string | null } | null;
  phone?: { primaryPhoneNumber?: string | null; primaryPhoneCallingCode?: string | null } | null;
  chatLink?: { primaryLinkUrl?: string | null } | null;
};

/** Подписи совпадают с теми, что лежат в базе: брокер увидит их же в карточке. */
const OUTCOMES = [
  { value: 'NO_ANSWER', label: 'Не дозвонился', color: 'orange' },
  { value: 'THINKING', label: 'Поговорил, думает', color: 'yellow' },
  { value: 'SHOWING_SET', label: 'Записал на показ', color: 'blue' },
  { value: 'NO_SHOW', label: 'На показ не пришёл', color: 'red' },
  { value: 'BOOKED', label: 'Внёс бронь', color: 'green' },
  { value: 'REFUSED', label: 'Отказ', color: 'gray' },
] as const;

const SNOOZES = [
  { label: 'Через час', hours: 1 },
  { label: 'Через 3 часа', hours: 3 },
  { label: 'Вечером', hours: 0, atHour: 18 },
  { label: 'Завтра утром', hours: 0, atHour: 10, tomorrow: true },
] as const;

const CHANNELS: Record<string, string> = {
  INSTAGRAM: 'Instagram',
  WHATSAPP: 'WhatsApp',
  TELEGRAM: 'Telegram',
  PHONE: 'Звонок',
  EMAIL: 'Почта',
};

const StyledPage = styled.div`
  align-items: flex-start;
  background: ${themeCssVariables.background.secondary};
  display: flex;
  flex: 1;
  justify-content: center;
  overflow: auto;
  padding: 16px;
`;

const StyledCard = styled.div`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.border.color.light};
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  max-width: 460px;
  padding: 20px;
  width: 100%;
`;

const StyledProgress = styled.div`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.sm};
  font-weight: ${themeCssVariables.font.weight.medium};
`;

const StyledBar = styled.div`
  background: ${themeCssVariables.background.transparent.light};
  border-radius: 2px;
  height: 4px;
  margin-top: 6px;
  overflow: hidden;
`;

const StyledBarFill = styled.div`
  background: ${themeCssVariables.color.blue};
  height: 100%;
  width: var(--done-share);
`;

const StyledName = styled.div`
  font-size: 24px;
  font-weight: ${themeCssVariables.font.weight.semiBold};
  line-height: 1.2;
`;

const StyledSub = styled.div<{ isLate: boolean }>`
  color: ${({ isLate }) =>
    isLate ? themeCssVariables.color.red : themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.sm};
  font-weight: ${({ isLate }) =>
    isLate ? themeCssVariables.font.weight.semiBold : themeCssVariables.font.weight.regular};
  margin-top: 4px;
`;

const StyledBigLink = styled.a`
  align-items: center;
  background: ${themeCssVariables.color.blue};
  border-radius: 8px;
  color: #fff;
  display: flex;
  font-size: 17px;
  font-weight: ${themeCssVariables.font.weight.semiBold};
  justify-content: center;
  min-height: 48px;
  text-decoration: none;
`;

const StyledChatLink = styled.a`
  align-items: center;
  background: ${themeCssVariables.background.transparent.light};
  border-radius: 8px;
  color: ${themeCssVariables.font.color.secondary};
  display: flex;
  font-size: ${themeCssVariables.font.size.md};
  justify-content: center;
  min-height: 40px;
  text-decoration: none;
`;

const StyledWants = styled.div`
  background: ${themeCssVariables.background.transparent.lighter};
  border-radius: 8px;
  color: ${themeCssVariables.font.color.secondary};
  display: flex;
  flex-direction: column;
  font-size: ${themeCssVariables.font.size.md};
  gap: 4px;
  padding: 12px;
`;

const StyledTodo = styled.div`
  border-top: 1px solid ${themeCssVariables.border.color.light};
  font-size: 18px;
  font-weight: ${themeCssVariables.font.weight.semiBold};
  padding-top: 16px;
`;

const StyledButtons = styled.div`
  display: grid;
  gap: 8px;
  grid-template-columns: 1fr 1fr;
`;

const StyledOutcome = styled.button`
  background: var(--pill-bg);
  border: 0;
  border-radius: 8px;
  color: var(--pill-fg);
  cursor: pointer;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.md};
  font-weight: ${themeCssVariables.font.weight.medium};
  min-height: 52px;
  padding: 8px;

  &:disabled {
    opacity: 0.5;
  }
`;

const StyledSnooze = styled.button`
  background: transparent;
  border: 1px solid ${themeCssVariables.border.color.medium};
  border-radius: 8px;
  color: ${themeCssVariables.font.color.secondary};
  cursor: pointer;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.md};
  grid-column: span 2;
  min-height: 44px;
`;

const StyledReasonBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 8px;
`;

const StyledInput = styled.input`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.border.color.medium};
  border-radius: 8px;
  color: ${themeCssVariables.font.color.primary};
  font-family: inherit;
  font-size: 16px;
  min-height: 44px;
  outline: none;
  padding: 0 12px;
`;

const StyledHint = styled.div`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.sm};
`;

const StyledDone = styled.div`
  color: ${themeCssVariables.font.color.secondary};
  font-size: 18px;
  padding: 48px 0;
  text-align: center;
`;

const waitingFor = (since?: string | null) => {
  if (!since) return '';
  const minutes = Math.round((Date.now() - new Date(since).getTime()) / 60000);
  if (minutes < 60) return `ждёт ${minutes} мин`;
  const hours = Math.round(minutes / 60);
  if (hours < 24) return `ждёт ${hours} ч`;
  return `ждёт ${Math.round(hours / 24)} дн`;
};

const money = (value: Lead['budgetMax']) => {
  const micros = value?.amountMicros;
  if (micros === null || micros === undefined) return null;
  const amount = Number(micros) / 1_000_000;
  if (!Number.isFinite(amount) || amount === 0) return null;
  const short =
    amount >= 1000 ? `${Math.round(amount / 1000)} тыс` : `${Math.round(amount)}`;
  return `до ${short} ${value?.currencyCode ?? ''}`.trim();
};

const snoozeUntil = (option: (typeof SNOOZES)[number]) => {
  const when = new Date();
  if ('tomorrow' in option && option.tomorrow) when.setDate(when.getDate() + 1);
  if ('atHour' in option && option.atHour) {
    when.setHours(option.atHour, 0, 0, 0);
    if (when.getTime() < Date.now()) when.setDate(when.getDate() + 1);
  } else {
    when.setHours(when.getHours() + option.hours);
  }
  return when.toISOString();
};

export const WorkQueuePage = () => {
  const me = useAtomStateValue(currentWorkspaceMemberState) as Member | null;
  const [askReason, setAskReason] = useState(false);
  const [reason, setReason] = useState('');
  const [showSnooze, setShowSnooze] = useState(false);
  const [busy, setBusy] = useState(false);

  const { records: tasks, refetch: refetchTasks } = useFindManyRecords<Task>({
    objectNameSingular: 'task',
    limit: 500,
  });
  const { records: targets } = useFindManyRecords<TaskTarget>({
    objectNameSingular: 'taskTarget',
    limit: 500,
  });
  const { records: leads } = useFindManyRecords<Lead>({
    objectNameSingular: 'opportunity',
    limit: 500,
  });

  const { updateOneRecord } = useUpdateOneRecord();

  const queue = useMemo(() => {
    const now = Date.now();
    return tasks
      .filter(
        (task) =>
          task.assigneeId === me?.id &&
          (task.status === 'TODO' || task.status === 'IN_PROGRESS') &&
          (!task.scheduledAt || new Date(task.scheduledAt).getTime() <= now),
      )
      .sort((a, b) => {
        const left = a.dueAt ? new Date(a.dueAt).getTime() : Number.MAX_SAFE_INTEGER;
        const right = b.dueAt ? new Date(b.dueAt).getTime() : Number.MAX_SAFE_INTEGER;
        return left - right;
      });
  }, [tasks, me?.id]);

  const doneToday = useMemo(() => {
    const dayStart = new Date().setHours(0, 0, 0, 0);
    return tasks.filter(
      (task) =>
        task.assigneeId === me?.id &&
        task.status === 'DONE' &&
        task.updatedAt &&
        new Date(task.updatedAt).getTime() >= dayStart,
    ).length;
  }, [tasks, me?.id]);

  const task = queue[0];

  const lead = useMemo(() => {
    if (!task) return null;
    const leadId = targets.find((target) => target.taskId === task.id)
      ?.targetOpportunityId;
    return leads.find((item) => item.id === leadId) ?? null;
  }, [task, targets, leads]);

  const finish = async () => {
    setAskReason(false);
    setReason('');
    setShowSnooze(false);
    await refetchTasks();
    setBusy(false);
  };

  const pick = async (value: string) => {
    if (!task || busy) return;

    // Отказ без причины триггер не пропустит — спрашиваем до отправки,
    // иначе кнопка молча ничего не сделает и это выглядит поломкой.
    if (value === 'REFUSED' && !lead?.lostReason?.trim() && !reason.trim()) {
      setAskReason(true);
      return;
    }

    setBusy(true);
    if (value === 'REFUSED' && reason.trim() && lead) {
      await updateOneRecord({
        idToUpdate: lead.id,
        updateOneRecordInput: { lostReason: reason.trim() },
        objectNameSingular: 'opportunity',
      });
    }
    await updateOneRecord({
      idToUpdate: task.id,
      updateOneRecordInput: { outcome: value },
      objectNameSingular: 'task',
    });
    await finish();
  };

  const snooze = async (option: (typeof SNOOZES)[number]) => {
    if (!task || busy) return;
    setBusy(true);
    await updateOneRecord({
      idToUpdate: task.id,
      updateOneRecordInput: {
        scheduledAt: snoozeUntil(option),
        snoozeCount: (task.snoozeCount ?? 0) + 1,
      },
      objectNameSingular: 'task',
    });
    await finish();
  };

  if (!task) {
    return (
      <StyledPage>
        <StyledCard>
          <StyledDone>
            На сегодня всё.
            <br />
            {doneToday > 0
              ? `Закрыто задач: ${doneToday}.`
              : 'Новые заявки появятся здесь сами.'}
          </StyledDone>
        </StyledCard>
      </StyledPage>
    );
  }

  const total = queue.length + doneToday;
  const phone = lead?.phone?.primaryPhoneNumber
    ? `${lead.phone.primaryPhoneCallingCode ?? ''}${lead.phone.primaryPhoneNumber}`
    : null;
  const wants = [money(lead?.budgetMax), lead?.rooms ? `${lead.rooms} комн.` : null,
    lead?.district || null].filter(Boolean);
  const isLate = Boolean(task.dueAt && new Date(task.dueAt).getTime() < Date.now());

  return (
    <StyledPage>
      <StyledCard>
        <StyledProgress>
          Осталось {queue.length} из {total}
          <StyledBar>
            <StyledBarFill
              style={
                {
                  '--done-share': `${total ? (doneToday / total) * 100 : 0}%`,
                } as React.CSSProperties
              }
            />
          </StyledBar>
        </StyledProgress>

        <div>
          <StyledName>{lead?.name || 'Без имени'}</StyledName>
          <StyledSub isLate={isLate}>
            {[CHANNELS[lead?.channel ?? ''] ?? lead?.channel, waitingFor(lead?.createdAt)]
              .filter(Boolean)
              .join(' · ')}
          </StyledSub>
        </div>

        {phone && <StyledBigLink href={`tel:${phone}`}>Позвонить {phone}</StyledBigLink>}
        {lead?.chatLink?.primaryLinkUrl && (
          <StyledChatLink
            href={lead.chatLink.primaryLinkUrl}
            target="_blank"
            rel="noreferrer"
          >
            Открыть переписку
          </StyledChatLink>
        )}

        {(wants.length > 0 || lead?.comment) && (
          <StyledWants>
            {wants.length > 0 && <div>{wants.join(' · ')}</div>}
            {lead?.comment && <div>{lead.comment}</div>}
          </StyledWants>
        )}

        <StyledTodo>
          {task.title || 'Задача'}
          {Boolean(task.snoozeCount) && (
            <StyledHint>Откладывали {task.snoozeCount} раз</StyledHint>
          )}
        </StyledTodo>

        {askReason ? (
          <StyledReasonBox>
            <StyledHint>Почему отказ? Без этого заявку не закрыть.</StyledHint>
            <StyledInput
              autoFocus
              value={reason}
              placeholder="Дорого, купил в другом месте, передумал…"
              onChange={(event) => setReason(event.target.value)}
            />
            <StyledButtons>
              <StyledSnooze type="button" onClick={() => setAskReason(false)}>
                Назад
              </StyledSnooze>
              <StyledOutcome
                type="button"
                disabled={!reason.trim() || busy}
                style={
                  {
                    '--pill-bg': 'var(--t-tag-background-gray)',
                    '--pill-fg': 'var(--t-tag-text-gray)',
                  } as React.CSSProperties
                }
                onClick={() => pick('REFUSED')}
              >
                Закрыть как отказ
              </StyledOutcome>
            </StyledButtons>
          </StyledReasonBox>
        ) : showSnooze ? (
          <StyledButtons>
            {SNOOZES.map((option) => (
              <StyledSnooze
                key={option.label}
                type="button"
                style={{ gridColumn: 'span 1' }}
                onClick={() => snooze(option)}
              >
                {option.label}
              </StyledSnooze>
            ))}
            <StyledSnooze type="button" onClick={() => setShowSnooze(false)}>
              Назад
            </StyledSnooze>
          </StyledButtons>
        ) : (
          <StyledButtons>
            {OUTCOMES.map((outcome) => (
              <StyledOutcome
                key={outcome.value}
                type="button"
                disabled={busy}
                style={
                  {
                    '--pill-bg': `var(--t-tag-background-${outcome.color})`,
                    '--pill-fg': `var(--t-tag-text-${outcome.color})`,
                  } as React.CSSProperties
                }
                onClick={() => pick(outcome.value)}
              >
                {outcome.label}
              </StyledOutcome>
            ))}
            <StyledSnooze type="button" onClick={() => setShowSnooze(true)}>
              Отложить
            </StyledSnooze>
          </StyledButtons>
        )}
      </StyledCard>
    </StyledPage>
  );
};
