/**
 * Исходы по видам задач — явный флоу на каждую.
 *
 * На показе бессмысленно предлагать «не дозвонился», на договоре —
 * «записал на показ». Поэтому набор кнопок зависит от вида задачи.
 *
 * У каждого исхода свой вопрос. Общий «что получилось, о чём договорились»
 * не годился: у «не отвечает» договариваться не с кем, там нужен не текст,
 * а срок следующей попытки. Поэтому исход сам говорит, что спросить:
 *
 *   when   — только когда вернуться. Подпись пишется сама.
 *   note   — короткий текст своими словами, вопрос у каждого свой.
 *   both   — сначала дата, потом текст.
 *   pick   — выбор из готовых причин, печатать нечего.
 *
 * Та же карта продублирована в триггере `ops.task_outcome_apply`: там она
 * решает, какую стадию ставить и какую задачу заводить. Общий справочник
 * потребовал бы отдельного объекта и ручки ради десятка строк, которые
 * меняются раз в полгода. Правишь здесь — правь и там.
 */

export type Ask = 'when' | 'note' | 'both' | 'pick';

/** Последний пункт любого списка причин: готовые варианты никогда
 *  не покрывают всё, и без него список становится клеткой. */
export const OTHER_CHOICE = 'Другое — напишу сам';

export type Outcome = {
  value: string;
  label: string;
  color: string;
  ask: Ask;
  /** Вопрос над полем ввода или над выбором даты. */
  prompt: string;
  /** Пример ответа — чтобы было видно, какой длины текст ждут. */
  placeholder?: string;
  /** Готовые варианты для `pick`. */
  choices?: readonly string[];
  /** Свои сроки для шага «когда». Первый — привычный по умолчанию. */
  whenOptions?: readonly { label: string; days: number }[];
  /** Подпись, которая запишется сама, когда печатать нечего. */
  autoNote?: string;
  /** Требовать бюджет или район перед тем, как считать клиента своим. */
  needsInfo?: boolean;
};

/** Когда вернуться к клиенту, который не ответил. */
export const RETRY_WHEN = [
  { label: 'Через 15 минут', minutes: 15 },
  { label: 'Через час', minutes: 60 },
  { label: 'Через 3 часа', minutes: 180 },
  { label: 'Завтра утром', minutes: 0, atHour: 10, tomorrow: true },
] as const;

/** Когда показ или возврат к отложенному клиенту. */
export const DAY_WHEN = [
  { label: 'Сегодня', days: 0 },
  { label: 'Завтра', days: 1 },
  { label: 'Послезавтра', days: 2 },
] as const;

const REFUSED = (prompt: string): Outcome => ({
  value: 'REFUSED',
  label: prompt === 'Почему сорвалось?' ? 'Сорвалось' : 'Отказ',
  color: 'red',
  ask: 'note',
  prompt,
  placeholder: 'Дорого, купил в другом месте, передумал',
});

export const CONTACT_FLOW: Outcome[] = [
  {
    value: 'NO_ANSWER',
    label: 'Не отвечает',
    color: 'orange',
    ask: 'when',
    prompt: 'Когда попробовать снова?',
    autoNote: 'Не дозвонился',
  },
  {
    value: 'THINKING',
    label: 'Думает',
    color: 'yellow',
    ask: 'both',
    prompt: 'Когда вернуться к нему?',
    placeholder: 'Что ищет, что смущает, когда решит',
    whenOptions: [
      { label: 'Через 2 дня', days: 2 },
      { label: 'Завтра', days: 1 },
      { label: 'Через неделю', days: 7 },
    ],
    needsInfo: true,
  },
  {
    value: 'SHOWING_SET',
    label: 'Договорились на показ',
    color: 'blue',
    ask: 'both',
    prompt: 'Когда показ?',
    placeholder: 'Какой объект, во сколько, кто придёт',
  },
  {
    value: 'POSTPONED',
    label: 'Отложить надолго',
    color: 'sky',
    ask: 'both',
    prompt: 'Когда вернуться к клиенту?',
    placeholder: 'Ждёт продажи своей, копит, после отпуска',
  },
  REFUSED('Почему отказался?'),
  {
    value: 'NOT_OURS',
    label: 'Не наш клиент',
    color: 'gray',
    ask: 'pick',
    prompt: 'Почему не наш?',
    choices: [
      'Отметка в сторис',
      'Ищет работу',
      'Спам или реклама',
      'Другой город',
      'Ошибся адресом',
      OTHER_CHOICE,
    ],
  },
];

export const MANUAL_FLOW: Outcome[] = [
  {
    value: 'COMPLETED',
    label: 'Сделал',
    color: 'green',
    ask: 'note',
    prompt: 'Что сделал?',
    placeholder: 'Коротко, для истории',
  },
  {
    value: 'DELAYED',
    label: 'Перенести',
    color: 'orange',
    ask: 'both',
    prompt: 'На когда перенести?',
    placeholder: 'Почему переносится',
  },
  {
    value: 'DROPPED',
    label: 'Отменить',
    color: 'gray',
    ask: 'pick',
    prompt: 'Почему отменяем?',
    choices: [
      'Больше не нужно',
      'Сделал кто-то другой',
      'Завёл по ошибке',
      OTHER_CHOICE,
    ],
  },
];

export const FLOW: Record<string, Outcome[]> = {
  FIRST_TOUCH: CONTACT_FLOW,
  FOLLOWUP: CONTACT_FLOW,
  MANUAL: MANUAL_FLOW,
  SHOWING: [
    {
      value: 'THINKING',
      label: 'Показ был, думает',
      color: 'yellow',
      ask: 'note',
      prompt: 'Что сказал после показа?',
      placeholder: 'Понравилось или нет, что смущает',
    },
    {
      value: 'NO_SHOW',
      label: 'Не пришёл',
      color: 'red',
      ask: 'when',
      prompt: 'Когда связаться?',
      autoNote: 'На показ не пришёл',
    },
    {
      value: 'RESCHEDULED',
      label: 'Перенесли',
      color: 'blue',
      ask: 'both',
      prompt: 'На когда перенесли?',
      placeholder: 'Почему перенесли',
    },
    {
      value: 'BOOKED',
      label: 'Внёс бронь',
      color: 'purple',
      ask: 'both',
      prompt: 'Когда подписываем договор?',
      placeholder: 'Объект, квартира, сумма брони',
      whenOptions: [
        { label: 'Через 3 дня', days: 3 },
        { label: 'Завтра', days: 1 },
        { label: 'Через неделю', days: 7 },
      ],
    },
    REFUSED('Почему отказался?'),
  ],
  CONTRACT: [
    {
      value: 'CONTRACT_SIGNED',
      label: 'Договор подписан',
      color: 'green',
      ask: 'both',
      prompt: 'Когда ждём оплату?',
      placeholder: 'Номер договора, сумма',
      whenOptions: [
        { label: 'Через неделю', days: 7 },
        { label: 'Через 3 дня', days: 3 },
        { label: 'Через 2 недели', days: 14 },
      ],
    },
    {
      value: 'DELAYED',
      label: 'Переносится',
      color: 'orange',
      ask: 'both',
      prompt: 'Когда вернуться?',
      placeholder: 'Почему переносится',
    },
    REFUSED('Почему сорвалось?'),
  ],
  PAYMENT: [
    {
      value: 'PAID',
      label: 'Оплачено',
      color: 'green',
      ask: 'note',
      prompt: 'Сколько оплатил?',
      placeholder: 'Сумма и как платил',
    },
    {
      value: 'DELAYED',
      label: 'Ждём оплату',
      color: 'orange',
      ask: 'both',
      prompt: 'Когда ждём оплату?',
      placeholder: 'Что сказал клиент',
    },
    REFUSED('Почему сорвалось?'),
  ],
};

export const flowFor = (kind?: string | null) =>
  FLOW[kind ?? 'MANUAL'] ?? CONTACT_FLOW;

export const outcomeIn = (kind: string | null | undefined, value: string) =>
  flowFor(kind).find((item) => item.value === value);

/** Подпись исхода для истории — ищем по всем наборам сразу. */
export const outcomeLabel = (value?: string | null) =>
  Object.values(FLOW)
    .flat()
    .find((item) => item.value === value)?.label ??
  value ??
  null;

/**
 * Сборка набора кнопок из метаданных поля `outcome`.
 *
 * Зашитая выше карта — квартальная: показ, бронь, договор. Школе нужны
 * совсем другие исходы, и держать их в коде значит пересобирать образ
 * ради каждой правки формулировки. Поэтому карта переезжает в базу:
 *
 *   options  — надпись и цвет каждого исхода, по одному на кабинет;
 *   settings.flow — какой вид задачи какие исходы показывает и что
 *                   спрашивает у человека.
 *
 * Нет настройки — работает как раньше. Это нужно, чтобы Квартал не
 * моргнул, пока карта для него ещё не перенесена в базу.
 */
export type FlowStep = Omit<Outcome, 'label' | 'color'>;

type OptionLike = { value: string; label: string; color?: string | null };

export const buildFlow = (
  kind: string | null | undefined,
  options?: readonly OptionLike[] | null,
  settings?: unknown,
): Outcome[] => {
  const flow = (settings as { flow?: Record<string, FlowStep[]> } | null)?.flow;
  const steps = flow?.[kind ?? 'MANUAL'];

  if (!steps?.length) {
    return flowFor(kind);
  }

  const byValue = new Map((options ?? []).map((item) => [item.value, item]));

  return steps.map((step) => {
    const option = byValue.get(step.value);
    return {
      ...step,
      label: option?.label ?? step.value,
      color: option?.color ?? 'gray',
    };
  });
};

/** Подпись исхода по метаданным, с откатом на зашитую карту. */
export const labelFrom = (
  value: string | null | undefined,
  options?: readonly OptionLike[] | null,
) =>
  (options ?? []).find((item) => item.value === value)?.label ??
  outcomeLabel(value);
