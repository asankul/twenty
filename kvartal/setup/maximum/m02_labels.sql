-- Названия статусов, видов задач и исходов для Maximum English.
--
-- Отдельным файлом от m01: новое значение перечисления нельзя
-- использовать в той же транзакции, где оно добавлено, а install.sh
-- оборачивает каждый файл в свою транзакцию.
--
-- Порядок статусов — это порядок колонок на доске, он взят из схемы
-- коммерческого предложения.

-- ── 13 статусов ──────────────────────────────────────────────────────
update core."fieldMetadata" f
   set options = '[
  {"value":"NEW",          "label":"Новый в очереди",    "color":"gray",      "position":0},
  {"value":"IN_WORK",      "label":"В работе",           "color":"sky",       "position":1},
  {"value":"NO_ANSWER",    "label":"Недозвон",           "color":"orange",    "position":2},
  {"value":"QUALIFIED",    "label":"Квалифицирован",     "color":"turquoise", "position":3},
  {"value":"RECRUITING",   "label":"В наборе",           "color":"yellow",    "position":4},
  {"value":"TRIAL_BOOKED", "label":"Записан на пробное", "color":"blue",      "position":5},
  {"value":"AT_BRANCH",    "label":"В филиале",          "color":"purple",    "position":6},
  {"value":"UNPAID",       "label":"Не оплатил",         "color":"orange",    "position":7},
  {"value":"TRIAL_SET",    "label":"Пробное назначено",  "color":"blue",      "position":8},
  {"value":"NO_SHOW",      "label":"Неявка",             "color":"orange",    "position":9},
  {"value":"CLOSING",      "label":"Дожим",              "color":"yellow",    "position":10},
  {"value":"STUDENT",      "label":"Студент",            "color":"green",     "position":11},
  {"value":"LOST",         "label":"Потерян",            "color":"red",       "position":12}
]'::jsonb,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'opportunity'
 where f."objectMetadataId" = o.id and f.name = 'stage'
   and w."databaseSchema" = '__WS__';

-- ── Виды задач ───────────────────────────────────────────────────────
update core."fieldMetadata" f
   set options = '[
  {"value":"CALL",    "label":"Позвонить",        "color":"blue",   "position":0},
  {"value":"GROUP",   "label":"Подобрать группу", "color":"yellow", "position":1},
  {"value":"BRANCH",  "label":"Принять в филиале","color":"purple", "position":2},
  {"value":"PAYMENT", "label":"Дождаться оплаты", "color":"orange", "position":3},
  {"value":"TRIAL",   "label":"Провести пробное", "color":"green",  "position":4},
  {"value":"CLOSING", "label":"Дожать",           "color":"red",    "position":5},
  {"value":"MANUAL",  "label":"Своя задача",      "color":"gray",   "position":6}
]'::jsonb,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id and f.name = 'kind'
   and w."databaseSchema" = '__WS__';

-- ── Исходы ───────────────────────────────────────────────────────────
update core."fieldMetadata" f
   set options = '[
  {"value":"NO_ANSWER",       "label":"Не ответил",              "color":"orange", "position":0},
  {"value":"REACHED_SOLO",    "label":"Дозвонился — индивидуально","color":"turquoise","position":1},
  {"value":"REACHED_GROUP",   "label":"Дозвонился — в группу",   "color":"turquoise","position":2},
  {"value":"GROUP_FOUND",     "label":"Группа найдена",          "color":"blue",   "position":3},
  {"value":"GROUP_NONE",      "label":"Нет подходящих групп",    "color":"yellow", "position":4},
  {"value":"GROUP_READY",     "label":"Группа набралась",        "color":"green",  "position":5},
  {"value":"GROUP_FAILED",    "label":"Группа не собралась",     "color":"orange", "position":6},
  {"value":"PAID",            "label":"Оплатил",                 "color":"green",  "position":7},
  {"value":"NOT_PAID",        "label":"Не оплатил",              "color":"orange", "position":8},
  {"value":"WAITING_PAYMENT", "label":"Ждём оплату",             "color":"yellow", "position":9},
  {"value":"TRIAL_PAID",      "label":"Пришёл и оплатил",        "color":"green",  "position":10},
  {"value":"TRIAL_THINKING",  "label":"Пришёл, думает",          "color":"yellow", "position":11},
  {"value":"TRIAL_NOSHOW",    "label":"Не пришёл",               "color":"orange", "position":12},
  {"value":"RESCHEDULED",     "label":"Перенесли",               "color":"blue",   "position":13},
  {"value":"NOSHOW_AGAIN",    "label":"Снова не пришёл",         "color":"red",    "position":14},
  {"value":"CLOSED_PAID",     "label":"Дожали, оплатил",         "color":"green",  "position":15},
  {"value":"REFUSED",         "label":"Отказ",                   "color":"red",    "position":16},
  {"value":"COMPLETED",       "label":"Сделал",                  "color":"green",  "position":17},
  {"value":"DROPPED",         "label":"Отменить",                "color":"gray",   "position":18}
]'::jsonb,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id and f.name = 'outcome'
   and w."databaseSchema" = '__WS__';
