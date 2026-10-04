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
    ask: 'note',
    prompt: 'Что сказал клиент?',
    placeholder: 'Что ищет, что смущает, когда решит',
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
    ],
  },
];

export const FLOW: Record<string, Outcome[]> = {
  FIRST_TOUCH: CONTACT_FLOW,
  FOLLOWUP: CONTACT_FLOW,
  MANUAL: CONTACT_FLOW,
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
      ask: 'note',
      prompt: 'Что забронировал?',
      placeholder: 'Объект, квартира, сумма брони',
    },
    REFUSED('Почему отказался?'),
  ],
  CONTRACT: [
    {
      value: 'CONTRACT_SIGNED',
      label: 'Договор подписан',
      color: 'green',
      ask: 'note',
      prompt: 'Что подписали?',
      placeholder: 'Номер договора, сумма',
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
    .find((item) => item.value === value)?.label ?? value ?? null;
