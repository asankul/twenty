/**
 * Исходы по видам задач — явный флоу на каждую.
 *
 * На показе бессмысленно предлагать «не дозвонился», на договоре —
 * «записал на показ». Поэтому набор кнопок зависит от вида задачи,
 * а не один на всё. Подписи и значения совпадают с теми, что в базе:
 * брокер увидит их же в карточке заявки и в истории.
 *
 * Та же карта продублирована в триггере `ops.task_outcome_apply`. Общий
 * справочник потребовал бы отдельного объекта и ручки ради десятка строк,
 * которые меняются раз в полгода. Правишь здесь — правь и там.
 */
export type Outcome = {
  value: string;
  label: string;
  color: string;
  needsDate?: boolean;
  needsInfo?: boolean;
  needsReason?: boolean;
};

export const CONTACT_FLOW: Outcome[] = [
  { value: 'NO_ANSWER', label: 'Не отвечает', color: 'orange' },
  { value: 'THINKING', label: 'Думает', color: 'yellow', needsInfo: true },
  { value: 'SHOWING_SET', label: 'Договорились на показ', color: 'blue', needsDate: true },
  { value: 'POSTPONED', label: 'Отложить надолго', color: 'sky', needsDate: true },
  { value: 'REFUSED', label: 'Отказ', color: 'red', needsReason: true },
  { value: 'NOT_OURS', label: 'Не наш клиент', color: 'gray' },
];

export const FLOW: Record<string, Outcome[]> = {
  FIRST_TOUCH: CONTACT_FLOW,
  FOLLOWUP: CONTACT_FLOW,
  MANUAL: CONTACT_FLOW,
  SHOWING: [
    { value: 'THINKING', label: 'Показ был, думает', color: 'yellow' },
    { value: 'NO_SHOW', label: 'Не пришёл', color: 'red' },
    { value: 'RESCHEDULED', label: 'Перенесли', color: 'blue', needsDate: true },
    { value: 'BOOKED', label: 'Внёс бронь', color: 'purple' },
    { value: 'REFUSED', label: 'Отказ', color: 'red', needsReason: true },
  ],
  CONTRACT: [
    { value: 'CONTRACT_SIGNED', label: 'Договор подписан', color: 'green' },
    { value: 'DELAYED', label: 'Переносится', color: 'orange' },
    { value: 'REFUSED', label: 'Сорвалось', color: 'red', needsReason: true },
  ],
  PAYMENT: [
    { value: 'PAID', label: 'Оплачено', color: 'green' },
    { value: 'DELAYED', label: 'Ждём оплату', color: 'orange' },
    { value: 'REFUSED', label: 'Сорвалось', color: 'red', needsReason: true },
  ],
};

export const flowFor = (kind?: string | null) => FLOW[kind ?? 'MANUAL'] ?? CONTACT_FLOW;

/** Подпись над кнопкой выбора дня — зависит от того, что назначаем. */
export const DATE_PROMPT: Record<string, string> = {
  SHOWING_SET: 'Когда показ?',
  RESCHEDULED: 'На когда перенесли?',
  POSTPONED: 'Когда вернуться к клиенту?',
};
