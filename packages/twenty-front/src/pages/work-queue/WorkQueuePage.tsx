import { styled } from '@linaria/react';
import type React from 'react';
import { useEffect, useMemo, useRef, useState } from 'react';
import { themeCssVariables } from 'twenty-ui/theme';

import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { useCreateOneRecord } from '@/object-record/hooks/useCreateOneRecord';
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
  contactValue?: string | null;
  stage?: string | null;
  ownerId?: string | null;
  leadSource?: string | null;
  district?: string | null;
  rooms?: number | null;
  comment?: string | null;
  lastMessage?: string | null;
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

/** Когда показ. Время по умолчанию дневное — показы редко ставят ночью. */
/** Больше трёх попыток дозвона — уже не занятой клиент, а вечный лид. */
const MAX_NO_ANSWER = 3;

const SHOW_DAYS = [
  { label: 'Сегодня', days: 0 },
  { label: 'Завтра', days: 1 },
  { label: 'Послезавтра', days: 2 },
] as const;

const atDay = (days: number) => {
  const when = new Date();
  when.setDate(when.getDate() + days);
  when.setHours(14, 0, 0, 0);
  if (when.getTime() < Date.now()) when.setHours(new Date().getHours() + 2, 0, 0, 0);
  return when.toISOString();
};

/** Значения совпадают с теми, что в базе: подписи брокер увидит и в карточке. */
const NEW_CHANNELS = [
  { value: 'PHONE', label: 'Звонок' },
  { value: 'INSTAGRAM', label: 'Инстаграм' },
  { value: 'WHATSAPP', label: 'Вотсап' },
  { value: 'TELEGRAM', label: 'Телеграм' },
  { value: 'EMAIL', label: 'Почта' },
] as const;

const NEW_SOURCES = [
  { value: 'SRC_2', label: 'Звонок' },
  { value: 'SRC_3', label: 'Сайт' },
  { value: 'SRC_4', label: 'Рекомендация' },
  { value: 'SRC_6', label: 'Пришёл в офис' },
  { value: 'SRC_7', label: '2GIS' },
  { value: 'SRC_5', label: 'Наружная реклама' },
  { value: 'SRC_8', label: 'Другое' },
] as const;

/** Норматив первого касания — тот же, что у заявок из чата. */
const FIRST_TOUCH_MINUTES = 15;

const CHANNELS: Record<string, string> = {
  INSTAGRAM: 'Instagram',
  WHATSAPP: 'WhatsApp',
  TELEGRAM: 'Telegram',
  PHONE: 'Звонок',
  EMAIL: 'Почта',
};

const StyledPage = styled.div`
  align-items: center;
  flex-direction: column;
  gap: 8px;
  background: ${themeCssVariables.background.secondary};
  display: flex;
  flex: 1;
  justify-content: center;
  overflow: auto;
  padding: 16px;
`;

const StyledStack = styled.div`
  max-width: 460px;
  position: relative;
  width: 100%;
`;

/** Край следующей карточки: видно, что работа не кончилась на этой. */
const StyledGhost = styled.div`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.border.color.light};
  border-radius: 12px;
  height: 100%;
  left: 0;
  opacity: 0.55;
  position: absolute;
  top: 10px;
  transform: scale(0.96);
  width: 100%;
`;

const StyledCard = styled.div<{ isLeaving: boolean }>`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.border.color.light};
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  opacity: ${({ isLeaving }) => (isLeaving ? 0 : 1)};
  padding: 20px;
  position: relative;
  transform: ${({ isLeaving }) =>
    isLeaving ? 'translateX(-110%) rotate(-5deg)' : 'none'};
  transition:
    transform 220ms cubic-bezier(0.4, 0, 0.2, 1),
    opacity 220ms ease;
  width: 100%;
  z-index: 1;

  animation: work-card-in 220ms cubic-bezier(0.16, 1, 0.3, 1);

  @keyframes work-card-in {
    from {
      opacity: 0;
      transform: translateY(14px) scale(0.97);
    }
    to {
      opacity: 1;
      transform: none;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    animation: none;
    transition: none;
  }
`;

const StyledWhose = styled.div`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.sm};
  margin-bottom: -8px;
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

const StyledSaid = styled.div`
  background: ${themeCssVariables.background.transparent.lighter};
  border-left: 3px solid ${themeCssVariables.color.blue};
  border-radius: 6px;
  color: ${themeCssVariables.font.color.primary};
  font-size: ${themeCssVariables.font.size.md};
  line-height: 1.45;
  padding: 10px 12px;
`;

const StyledSaidEmpty = styled.div`
  background: ${themeCssVariables.background.transparent.lighter};
  border-left: 3px solid ${themeCssVariables.border.color.medium};
  border-radius: 6px;
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.md};
  padding: 10px 12px;
`;

const StyledFacts = styled.div`
  display: flex;
  flex-direction: column;
`;

const StyledFact = styled.div`
  align-items: center;
  border-bottom: 1px solid ${themeCssVariables.border.color.light};
  display: flex;
  gap: 12px;
  justify-content: space-between;
  min-height: 40px;

  &:last-child {
    border-bottom: 0;
  }
`;

const StyledFactLabel = styled.span`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.md};
  flex-shrink: 0;
`;

const StyledFactValue = styled.button<{ isEmpty: boolean; canEdit: boolean }>`
  background: transparent;
  border: 0;
  color: ${({ isEmpty }) =>
    isEmpty ? themeCssVariables.font.color.light : themeCssVariables.font.color.primary};
  cursor: ${({ canEdit }) => (canEdit ? 'pointer' : 'default')};
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.md};
  font-weight: ${themeCssVariables.font.weight.medium};
  min-height: 36px;
  padding: 0 4px;
  text-align: right;
`;

const StyledFactInput = styled.input`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.color.blue};
  border-radius: 6px;
  color: ${themeCssVariables.font.color.primary};
  font-family: inherit;
  font-size: 16px;
  max-width: 180px;
  min-height: 36px;
  outline: none;
  padding: 0 8px;
  text-align: right;
`;

/** Очередь состоит из задач, а не из заявок: у заявки нет ни срока, ни
 *  действия. Но заявка на карточке подана крупно, и без подписи непонятно,
 *  что именно надо сделать. */
const StyledTodoLabel = styled.div`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.xs};
  font-weight: ${themeCssVariables.font.weight.medium};
  letter-spacing: 0.06em;
  margin-bottom: 4px;
  text-transform: uppercase;
`;

const StyledDeadline = styled.div<{ late: boolean }>`
  background: ${({ late }) =>
    late ? 'var(--t-tag-background-red)' : 'var(--t-tag-background-gray)'};
  border-radius: 6px;
  color: ${({ late }) => (late ? 'var(--t-tag-text-red)' : 'var(--t-tag-text-gray)')};
  display: inline-block;
  font-size: ${themeCssVariables.font.size.sm};
  font-weight: ${themeCssVariables.font.weight.medium};
  margin-top: 6px;
  padding: 3px 8px;
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

/** Нативный выбор даты внутри кнопки: своего календаря не рисуем,
 *  на телефоне системный удобнее и привычнее. */
const StyledDayInput = styled.input`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.secondary};
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.sm};
  outline: none;
  width: 100%;
`;

const StyledHint = styled.div`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.sm};
`;

const StyledAddLink = styled.button`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.tertiary};
  cursor: pointer;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.md};
  min-height: 40px;
  text-decoration: underline;
`;

const StyledFormRow = styled.label`
  display: flex;
  flex-direction: column;
  gap: 4px;
`;

const StyledFormLabel = styled.span`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.sm};
`;

const StyledSelect = styled.select`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.border.color.medium};
  border-radius: 8px;
  color: ${themeCssVariables.font.color.primary};
  font-family: inherit;
  font-size: 16px;
  min-height: 44px;
  padding: 0 8px;
`;

const StyledDone = styled.div`
  color: ${themeCssVariables.font.color.secondary};
  font-size: 18px;
  padding: 48px 0;
  text-align: center;
`;

/** Срок самой задачи: сколько осталось или на сколько просрочена. */
const deadlineText = (dueAt?: string | null) => {
  if (!dueAt) return null;
  const minutes = Math.round((new Date(dueAt).getTime() - Date.now()) / 60000);
  const late = minutes < 0;
  const left = Math.abs(minutes);
  const amount =
    left < 60
      ? `${left} мин`
      : left < 1440
        ? `${Math.round(left / 60)} ч`
        : `${Math.round(left / 1440)} дн`;
  return { late, text: late ? `просрочено на ${amount}` : `осталось ${amount}` };
};

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
  // Бюджеты тут от восьмидесяти тысяч до семи миллионов сомов — круглим
  // до тысяч, иначе в строку не влезает и читается хуже.
  const short =
    amount >= 1000
      ? `${Math.round(amount / 1000).toLocaleString('ru-RU')} тыс`
      : `${Math.round(amount)}`;
  const currency = value?.currencyCode === 'KGS' ? 'сом' : (value?.currencyCode ?? '');
  return `${short} ${currency}`.trim();
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

/**
 * Строка «что известно». Показывается всегда, даже когда пусто: прочерк
 * говорит брокеру, чего не хватает, и даёт вписать прямо во время разговора.
 * Иначе эти поля не заполняются никогда — сейчас бюджет известен у шести
 * заявок из ста двадцати семи.
 */
const Fact = ({
  label,
  value,
  placeholder,
  onSave,
}: {
  label: string;
  value: string | null;
  placeholder?: string;
  onSave?: (raw: string) => void;
}) => {
  const [editing, setEditing] = useState(false);
  const [draft, setDraft] = useState('');
  // Escape убирает поле, и браузер может на этом выстрелить «ушёл из поля».
  // Без флага отмена всё равно сохраняла бы набранное.
  const cancelled = useRef(false);

  const commit = () => {
    setEditing(false);
    if (cancelled.current) {
      cancelled.current = false;
      return;
    }
    const trimmed = draft.trim();
    if (trimmed !== '') onSave?.(trimmed);
  };

  return (
    <StyledFact>
      <StyledFactLabel>{label}</StyledFactLabel>
      {editing ? (
        <StyledFactInput
          autoFocus
          value={draft}
          placeholder={placeholder}
          inputMode={placeholder === 'сом' || label === 'Комнат' ? 'numeric' : 'text'}
          onChange={(event) => setDraft(event.target.value)}
          onBlur={commit}
          onKeyDown={(event) => {
            if (event.key === 'Enter') event.currentTarget.blur();
            if (event.key === 'Escape') {
              cancelled.current = true;
              setEditing(false);
            }
          }}
        />
      ) : (
        <StyledFactValue
          type="button"
          isEmpty={!value}
          canEdit={Boolean(onSave)}
          onClick={() => {
            if (!onSave) return;
            cancelled.current = false;
            setDraft(value ?? '');
            setEditing(true);
          }}
        >
          {value ?? (onSave ? '— вписать' : '—')}
        </StyledFactValue>
      )}
    </StyledFact>
  );
};

export const WorkQueuePage = () => {
  const me = useAtomStateValue(currentWorkspaceMemberState) as Member | null;
  const [pending, setPending] = useState<string | null>(null);
  const [step, setStep] = useState<'date' | 'need' | 'note'>('note');
  const [nextAt, setNextAt] = useState<string | null>(null);
  const [note, setNote] = useState('');
  const [showSnooze, setShowSnooze] = useState(false);
  const [busy, setBusy] = useState(false);
  const [leaving, setLeaving] = useState(false);
  // Срок должен тикать, а не замирать на момент открытия: брокер держит
  // экран открытым весь день, и «осталось 12 мин» через час уже враньё.
  const [, setTick] = useState(0);
  const [creating, setCreating] = useState(false);
  const [draft, setDraft] = useState({
    name: '',
    phone: '',
    channel: 'PHONE',
    leadSource: 'SRC_2',
    budget: '',
    comment: '',
  });

  useEffect(() => {
    const id = setInterval(() => setTick((n) => n + 1), 30_000);
    return () => clearInterval(id);
  }, []);

  const { records: tasks, refetch: refetchTasks } = useFindManyRecords<Task>({
    objectNameSingular: 'task',
    limit: 500,
  });
  const { records: targets, refetch: refetchTargets } = useFindManyRecords<TaskTarget>({
    objectNameSingular: 'taskTarget',
    limit: 500,
  });
  const { records: leads, refetch: refetchLeads } = useFindManyRecords<Lead>({
    objectNameSingular: 'opportunity',
    limit: 500,
  });

  const { updateOneRecord } = useUpdateOneRecord();
  const { createOneRecord: createComment } = useCreateOneRecord({
    objectNameSingular: 'taskComment',
  });
  const { createOneRecord: createLead } = useCreateOneRecord<Lead>({
    objectNameSingular: 'opportunity',
  });
  const { createOneRecord: createTask } = useCreateOneRecord<Task>({
    objectNameSingular: 'task',
  });
  const { createOneRecord: createTarget } = useCreateOneRecord({
    objectNameSingular: 'taskTarget',
  });

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

  const myName = [me?.name?.firstName, me?.name?.lastName]
    .filter(Boolean)
    .join(' ')
    .trim();

  const task = queue[0];

  // Сколько раз уже не дозвонились по этой заявке. После третьей попытки
  // кнопку убираем: иначе лид возвращается месяцами и живёт вечно.
  const noAnswerTries = useMemo(() => {
    if (!task) return 0;
    const leadId = targets.find((t) => t.taskId === task.id)?.targetOpportunityId;
    if (!leadId) return 0;
    const sameLead = new Set(
      targets.filter((t) => t.targetOpportunityId === leadId).map((t) => t.taskId),
    );
    return tasks.filter((t) => sameLead.has(t.id) && t.outcome === 'NO_ANSWER').length;
  }, [task, targets, tasks]);

  const lead = useMemo(() => {
    if (!task) return null;
    const leadId = targets.find((target) => target.taskId === task.id)
      ?.targetOpportunityId;
    return leads.find((item) => item.id === leadId) ?? null;
  }, [task, targets, leads]);

  const finish = async () => {
    setPending(null);
    setStep('note');
    setNextAt(null);
    setNote('');
    setShowSnooze(false);
    // Обновляем все три списка, а не только задачи: у новой задачи своя
    // связка с заявкой, и без неё карточка показывала «Заявка недоступна»
    // на собственном же лиде.
    await Promise.all([refetchTasks(), refetchTargets(), refetchLeads()]);
    setLeaving(false);
    setBusy(false);
  };

  /** Результат всегда подписывается: иначе через месяц никто не вспомнит,
   *  о чём говорили, и история сделки превращается в набор цветных меток. */
  const confirm = async () => {
    const text = note.trim();
    if (!task || !pending || text === '' || busy) return;

    setBusy(true);
    setLeaving(true);

    await createComment({ text, taskId: task.id, authorId: me?.id });

    if (pending === 'REFUSED' && lead) {
      await updateOneRecord({
        idToUpdate: lead.id,
        updateOneRecordInput: { lostReason: text },
        objectNameSingular: 'opportunity',
      });
    }

    await updateOneRecord({
      idToUpdate: task.id,
      updateOneRecordInput: {
        outcome: pending,
        ...(nextAt ? { nextAt } : {}),
      },
      objectNameSingular: 'task',
    });
    await finish();
  };

  /** Правка заявки прямо из карточки: бюджет и район заполняются во время
   *  разговора или не заполняются никогда. */
  const saveLead = async (input: Record<string, unknown>) => {
    if (!lead) return;
    await updateOneRecord({
      idToUpdate: lead.id,
      updateOneRecordInput: input,
      objectNameSingular: 'opportunity',
    });
    await refetchLeads();
  };

  /** Заявка со звонка: заводим её вместе с задачей первого касания, иначе
   *  она не попадёт ни в очередь, ни под норматив. Срок по SLA проставит база. */
  const submitNew = async () => {
    const name = draft.name.trim();
    if (name === '' || busy) return;
    setBusy(true);

    const amount = Number(draft.budget.replace(/[^0-9]/g, ''));
    const phone = draft.phone.replace(/[^0-9+]/g, '');

    const lead = await createLead({
      name,
      stage: 'NEW',
      channel: draft.channel,
      leadSource: draft.leadSource,
      ownerId: me?.id,
      ...(phone
        ? { phone: { primaryPhoneNumber: phone, primaryPhoneCallingCode: '+996' } }
        : {}),
      ...(amount
        ? { budgetMax: { amountMicros: amount * 1_000_000, currencyCode: 'KGS' } }
        : {}),
      ...(draft.comment.trim() ? { comment: draft.comment.trim() } : {}),
    });

    const created = await createTask({
      title: `Первый контакт — ${name}`,
      status: 'TODO',
      assigneeId: me?.id,
      dueAt: new Date(Date.now() + FIRST_TOUCH_MINUTES * 60000).toISOString(),
    });

    if (lead?.id && created?.id) {
      await createTarget({ taskId: created.id, targetOpportunityId: lead.id });
    }

    setDraft({
      name: '',
      phone: '',
      channel: 'PHONE',
      leadSource: 'SRC_2',
      budget: '',
      comment: '',
    });
    setCreating(false);
    await Promise.all([refetchTasks(), refetchTargets(), refetchLeads()]);
    setBusy(false);
  };

  const snooze = async (option: (typeof SNOOZES)[number]) => {
    if (!task || busy) return;
    setBusy(true);
    setLeaving(true);
    await updateOneRecord({
      idToUpdate: task.id,
      // Только срок. «Переносов» закрыто на запись всем ролям и считается
      // триггером: пришли мы его — сервер отклонит мутацию целиком.
      updateOneRecordInput: { scheduledAt: snoozeUntil(option) },
      objectNameSingular: 'task',
    });
    await finish();
  };

  const newLeadForm = (
    <StyledCard isLeaving={false}>
      {myName && <StyledWhose>Новая заявка · {myName}</StyledWhose>}
      <StyledFormRow>
        <StyledFormLabel>Имя клиента</StyledFormLabel>
        <StyledInput
          autoFocus
          value={draft.name}
          placeholder="Как зовут"
          onChange={(event) => setDraft({ ...draft, name: event.target.value })}
        />
      </StyledFormRow>
      <StyledFormRow>
        <StyledFormLabel>Телефон</StyledFormLabel>
        <StyledInput
          value={draft.phone}
          inputMode="tel"
          placeholder="555 123456"
          onChange={(event) => setDraft({ ...draft, phone: event.target.value })}
        />
      </StyledFormRow>
      <StyledFormRow>
        <StyledFormLabel>Откуда пришёл</StyledFormLabel>
        <StyledSelect
          value={draft.leadSource}
          onChange={(event) =>
            setDraft({ ...draft, leadSource: event.target.value })
          }
        >
          {NEW_SOURCES.map((item) => (
            <option key={item.value} value={item.value}>
              {item.label}
            </option>
          ))}
        </StyledSelect>
      </StyledFormRow>
      <StyledFormRow>
        <StyledFormLabel>Как связываться</StyledFormLabel>
        <StyledSelect
          value={draft.channel}
          onChange={(event) => setDraft({ ...draft, channel: event.target.value })}
        >
          {NEW_CHANNELS.map((item) => (
            <option key={item.value} value={item.value}>
              {item.label}
            </option>
          ))}
        </StyledSelect>
      </StyledFormRow>
      <StyledFormRow>
        <StyledFormLabel>Бюджет до, сом</StyledFormLabel>
        <StyledInput
          value={draft.budget}
          inputMode="numeric"
          placeholder="необязательно"
          onChange={(event) => setDraft({ ...draft, budget: event.target.value })}
        />
      </StyledFormRow>
      <StyledFormRow>
        <StyledFormLabel>Заметка</StyledFormLabel>
        <StyledInput
          value={draft.comment}
          placeholder="необязательно"
          onChange={(event) => setDraft({ ...draft, comment: event.target.value })}
        />
      </StyledFormRow>
      <StyledButtons>
        <StyledSnooze type="button" onClick={() => setCreating(false)}>
          Отмена
        </StyledSnooze>
        <StyledOutcome
          type="button"
          disabled={!draft.name.trim() || busy}
          style={
            {
              '--pill-bg': 'var(--t-tag-background-green)',
              '--pill-fg': 'var(--t-tag-text-green)',
            } as React.CSSProperties
          }
          onClick={submitNew}
        >
          Завести
        </StyledOutcome>
      </StyledButtons>
    </StyledCard>
  );

  if (creating) {
    return <StyledPage>{newLeadForm}</StyledPage>;
  }

  if (!task) {
    return (
      <StyledPage>
        <StyledCard isLeaving={false}>
          {myName && <StyledWhose>Моя работа · {myName}</StyledWhose>}
          <StyledDone>
            На сегодня всё.
            <br />
            {doneToday > 0
              ? `Закрыто задач: ${doneToday}.`
              : 'Новые заявки появятся здесь сами.'}
          </StyledDone>
          <StyledAddLink type="button" onClick={() => setCreating(true)}>
            Завести заявку со звонка
          </StyledAddLink>
        </StyledCard>
      </StyledPage>
    );
  }

  const total = queue.length + doneToday;
  const phone = lead?.phone?.primaryPhoneNumber
    ? `${lead.phone.primaryPhoneCallingCode ?? ''}${lead.phone.primaryPhoneNumber}`
    : null;
  const isLate = Boolean(task.dueAt && new Date(task.dueAt).getTime() < Date.now());

  return (
    <StyledPage>
      <StyledStack>
        {queue.length > 1 && <StyledGhost />}
        <StyledCard key={task.id} isLeaving={leaving}>
        {myName && <StyledWhose>Моя работа · {myName}</StyledWhose>}

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
          <StyledName>{lead?.name || 'Заявка недоступна'}</StyledName>
          <StyledSub isLate={isLate}>
            {[
              CHANNELS[lead?.channel ?? ''] ?? lead?.channel,
              lead?.contactValue,
              waitingFor(lead?.createdAt),
            ]
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

        {lead?.lastMessage ? (
          <StyledSaid>«{lead.lastMessage}»</StyledSaid>
        ) : (
          <StyledSaidEmpty>Клиент ничего не написал</StyledSaidEmpty>
        )}

        <StyledFacts>
          <Fact label="Телефон" value={phone} />
          <Fact
            label="Бюджет до"
            value={money(lead?.budgetMax)}
            placeholder="сом"
            onSave={(raw) => {
              const amount = Number(raw.replace(/[^0-9]/g, ''));
              if (!amount) return;
              saveLead({
                budgetMax: {
                  amountMicros: amount * 1_000_000,
                  currencyCode: lead?.budgetMax?.currencyCode ?? 'KGS',
                },
              });
            }}
          />
          <Fact
            label="Комнат"
            value={lead?.rooms ? String(lead.rooms) : null}
            placeholder="2"
            onSave={(raw) => {
              const rooms = Number(raw.replace(/[^0-9]/g, ''));
              if (rooms) saveLead({ rooms });
            }}
          />
          <Fact
            label="Район"
            value={lead?.district || null}
            placeholder="Асанбай"
            onSave={(district) => saveLead({ district })}
          />
          <Fact
            label="Заметка"
            value={lead?.comment || null}
            placeholder="о чём договорились"
            onSave={(comment) => saveLead({ comment })}
          />
        </StyledFacts>

        <StyledTodo>
          <StyledTodoLabel>Что сделать</StyledTodoLabel>
          {task.title || 'Задача'}
          {(() => {
            const deadline = deadlineText(task.dueAt);
            return deadline ? (
              <StyledDeadline late={deadline.late}>{deadline.text}</StyledDeadline>
            ) : null;
          })()}
          {Boolean(task.snoozeCount) && (
            <StyledHint>Откладывали {task.snoozeCount} раз</StyledHint>
          )}
        </StyledTodo>

        {!lead ? (
          <StyledWants>
            Эта задача стоит на заявке другой команды — её не видно по правам.
            Скажите старшему, он передаст задачу владельцу заявки.
          </StyledWants>
        ) : pending && step === 'date' ? (
          <StyledReasonBox>
            <StyledHint>Когда показ?</StyledHint>
            <StyledButtons>
              {SHOW_DAYS.map((day) => (
                <StyledSnooze
                  key={day.label}
                  type="button"
                  style={{ gridColumn: 'span 1' }}
                  onClick={() => {
                    setNextAt(atDay(day.days));
                    setStep('note');
                  }}
                >
                  {day.label}
                </StyledSnooze>
              ))}
              <StyledSnooze type="button" style={{ gridColumn: 'span 1' }}>
                <StyledDayInput
                  type="datetime-local"
                  onChange={(event) => {
                    if (!event.target.value) return;
                    setNextAt(new Date(event.target.value).toISOString());
                    setStep('note');
                  }}
                />
              </StyledSnooze>
              <StyledSnooze type="button" onClick={() => setPending(null)}>
                Назад
              </StyledSnooze>
            </StyledButtons>
          </StyledReasonBox>
        ) : pending && step === 'need' ? (
          <StyledReasonBox>
            <StyledHint>
              Чтобы считать клиента квалифицированным, нужно хоть что-то про
              него знать. Впишите бюджет или район.
            </StyledHint>
            <StyledFacts>
              <Fact
                label="Бюджет до"
                value={money(lead?.budgetMax)}
                placeholder="сом"
                onSave={(raw) => {
                  const amount = Number(raw.replace(/[^0-9]/g, ''));
                  if (!amount) return;
                  saveLead({
                    budgetMax: {
                      amountMicros: amount * 1_000_000,
                      currencyCode: lead?.budgetMax?.currencyCode ?? 'KGS',
                    },
                  });
                }}
              />
              <Fact
                label="Район"
                value={lead?.district || null}
                placeholder="Асанбай"
                onSave={(district) => saveLead({ district })}
              />
            </StyledFacts>
            <StyledButtons>
              <StyledSnooze type="button" onClick={() => setPending(null)}>
                Назад
              </StyledSnooze>
              <StyledOutcome
                type="button"
                disabled={!lead?.budgetMax?.amountMicros && !lead?.district}
                style={
                  {
                    '--pill-bg': 'var(--t-tag-background-yellow)',
                    '--pill-fg': 'var(--t-tag-text-yellow)',
                  } as React.CSSProperties
                }
                onClick={() => setStep('note')}
              >
                Дальше
              </StyledOutcome>
            </StyledButtons>
          </StyledReasonBox>
        ) : pending ? (
          <StyledReasonBox>
            {pending !== 'REFUSED' && pending !== 'NO_ANSWER' && (
              <StyledFacts>
                <Fact
                  label="Бюджет до"
                  value={money(lead?.budgetMax)}
                  placeholder="сом"
                  onSave={(raw) => {
                    const amount = Number(raw.replace(/[^0-9]/g, ''));
                    if (!amount) return;
                    saveLead({
                      budgetMax: {
                        amountMicros: amount * 1_000_000,
                        currencyCode: lead?.budgetMax?.currencyCode ?? 'KGS',
                      },
                    });
                  }}
                />
                <Fact
                  label="Комнат"
                  value={lead?.rooms ? String(lead.rooms) : null}
                  placeholder="2"
                  onSave={(raw) => {
                    const rooms = Number(raw.replace(/[^0-9]/g, ''));
                    if (rooms) saveLead({ rooms });
                  }}
                />
                <Fact
                  label="Район"
                  value={lead?.district || null}
                  placeholder="Асанбай"
                  onSave={(district) => saveLead({ district })}
                />
              </StyledFacts>
            )}
            <StyledHint>
              {OUTCOMES.find((item) => item.value === pending)?.label}. Что
              получилось? Без этого задачу не закрыть.
            </StyledHint>
            <StyledInput
              autoFocus
              value={note}
              placeholder={
                pending === 'REFUSED'
                  ? 'Дорого, купил в другом месте, передумал…'
                  : 'Коротко: о чём договорились'
              }
              onChange={(event) => setNote(event.target.value)}
              onKeyDown={(event) => {
                if (event.key === 'Enter') confirm();
                if (event.key === 'Escape') setPending(null);
              }}
            />
            <StyledButtons>
              <StyledSnooze type="button" onClick={() => setPending(null)}>
                Назад
              </StyledSnooze>
              <StyledOutcome
                type="button"
                disabled={!note.trim() || busy}
                style={
                  {
                    '--pill-bg': `var(--t-tag-background-${
                      OUTCOMES.find((item) => item.value === pending)?.color ?? 'gray'
                    })`,
                    '--pill-fg': `var(--t-tag-text-${
                      OUTCOMES.find((item) => item.value === pending)?.color ?? 'gray'
                    })`,
                  } as React.CSSProperties
                }
                onClick={confirm}
              >
                Готово
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
            {OUTCOMES.filter(
              (outcome) =>
                outcome.value !== 'NO_ANSWER' || noAnswerTries < MAX_NO_ANSWER,
            ).map((outcome) => (
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
                onClick={() => {
                  setNote('');
                  setNextAt(null);
                  setPending(outcome.value);
                  // Показ без даты бессмыслен, а «думает» без бюджета
                  // и района не отличить от «ничего не узнал».
                  if (outcome.value === 'SHOWING_SET') {
                    setStep('date');
                  } else if (
                    outcome.value === 'THINKING' &&
                    !lead?.budgetMax?.amountMicros &&
                    !lead?.district
                  ) {
                    setStep('need');
                  } else {
                    setStep('note');
                  }
                }}
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
      </StyledStack>
      <StyledAddLink type="button" onClick={() => setCreating(true)}>
        Завести заявку со звонка
      </StyledAddLink>
    </StyledPage>
  );
};
