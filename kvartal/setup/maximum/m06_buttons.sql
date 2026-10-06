-- Кнопки исхода для каждого вида задачи — в метаданных, а не в коде.
--
-- Раньше набор кнопок был зашит в TaskFlow.ts и был общим на все
-- кабинеты. Для школы это не годится: там свои исходы, и менеджер видел
-- бы «Договорились на показ» и «Внёс бронь».
--
-- Теперь надписи и цвета берутся из options поля outcome, а что
-- показывать для какого вида задачи и что при этом спрашивать — отсюда,
-- из settings.flow. Кабинет без этой настройки работает по зашитой
-- карте, поэтому Квартал не заметит перемены.
--
-- Что означает ask:
--   when — только срок следующей попытки, подпись пишется сама
--   note — короткий текст своими словами
--   both — сначала дата, потом текст
--   pick — выбор из готовых причин

update core."fieldMetadata" f
   set settings = '{
  "flow": {
    "CALL": [
      {"value":"NO_ANSWER","ask":"when","prompt":"Когда перезвонить?","autoNote":"Не ответил"},
      {"value":"REACHED_SOLO","ask":"note","prompt":"О чём договорились?","placeholder":"Хочет индивидуально, уровень B1, вечером"},
      {"value":"REACHED_GROUP","ask":"note","prompt":"Что хочет: уровень, график, филиал?","placeholder":"B1, будни после 18, Асанбай"},
      {"value":"RESCHEDULED","ask":"both","prompt":"На какой день переносим пробное?","whenOptions":[{"label":"Завтра","days":1},{"label":"Через 2 дня","days":2},{"label":"Через неделю","days":7}]},
      {"value":"NOSHOW_AGAIN","ask":"note","prompt":"Что сказал во второй раз?","placeholder":"Передумал, не берёт трубку"},
      {"value":"REFUSED","ask":"note","prompt":"Почему отказался?","placeholder":"Дорого, нашёл другую школу, нет времени"}
    ],
    "GROUP": [
      {"value":"GROUP_FOUND","ask":"both","prompt":"Когда пробное занятие?","whenOptions":[{"label":"Завтра","days":1},{"label":"Через 2 дня","days":2},{"label":"Через неделю","days":7}]},
      {"value":"GROUP_NONE","ask":"note","prompt":"Что не подошло из имеющегося?","placeholder":"Нет групп на его уровень вечером"},
      {"value":"GROUP_READY","ask":"both","prompt":"Когда пробное занятие?","whenOptions":[{"label":"Завтра","days":1},{"label":"Через 2 дня","days":2},{"label":"Через неделю","days":7}]},
      {"value":"GROUP_FAILED","ask":"note","prompt":"Почему группа не собралась?","placeholder":"За месяц набрали двоих из пяти"},
      {"value":"REFUSED","ask":"note","prompt":"Почему отказался?","placeholder":"Устал ждать набора"}
    ],
    "BRANCH": [
      {"value":"PAID","ask":"both","prompt":"Когда пробное занятие?","whenOptions":[{"label":"Завтра","days":1},{"label":"Через 2 дня","days":2},{"label":"Через неделю","days":7}]},
      {"value":"NOT_PAID","ask":"note","prompt":"Что сказал про оплату?","placeholder":"Оплатит после зарплаты в пятницу"},
      {"value":"REFUSED","ask":"note","prompt":"Почему отказался?","placeholder":"Передумал на месте"}
    ],
    "PAYMENT": [
      {"value":"PAID","ask":"both","prompt":"Когда пробное занятие?","whenOptions":[{"label":"Завтра","days":1},{"label":"Через 2 дня","days":2},{"label":"Через неделю","days":7}]},
      {"value":"WAITING_PAYMENT","ask":"both","prompt":"Когда обещал оплатить?","whenOptions":[{"label":"Через 2 дня","days":2},{"label":"Завтра","days":1},{"label":"Через неделю","days":7}]},
      {"value":"REFUSED","ask":"note","prompt":"Почему не оплатил?","placeholder":"Передумал, выбрал другую школу"}
    ],
    "TRIAL": [
      {"value":"TRIAL_PAID","ask":"note","prompt":"Что выбрал: группа, график?","placeholder":"Группа B1, вторник и четверг в 19"},
      {"value":"TRIAL_THINKING","ask":"both","prompt":"Когда вернуться к нему?","whenOptions":[{"label":"Через 2 дня","days":2},{"label":"Завтра","days":1},{"label":"Через неделю","days":7}]},
      {"value":"TRIAL_NOSHOW","ask":"when","prompt":"Когда перезвонить?","autoNote":"Не пришёл на пробное"},
      {"value":"REFUSED","ask":"note","prompt":"Что не подошло на пробном?","placeholder":"Не понравился уровень группы"}
    ],
    "CLOSING": [
      {"value":"CLOSED_PAID","ask":"note","prompt":"Что оплатил?","placeholder":"Курс на три месяца, группа B1"},
      {"value":"TRIAL_THINKING","ask":"both","prompt":"Когда вернуться к нему?","whenOptions":[{"label":"Через 3 дня","days":3},{"label":"Завтра","days":1},{"label":"Через неделю","days":7}]},
      {"value":"REFUSED","ask":"note","prompt":"Почему отказался после пробного?","placeholder":"Дорого, не подошло расписание"}
    ],
    "MANUAL": [
      {"value":"COMPLETED","ask":"note","prompt":"Что сделал?","placeholder":"Позвонил, отправил реквизиты"},
      {"value":"DROPPED","ask":"pick","prompt":"Почему снимаем задачу?","choices":["Уже не нужно","Поставил по ошибке","Сделал кто-то другой"]}
    ]
  }
}'::jsonb,
       "updatedAt" = now()
  from core.workspace w
  join core."objectMetadata" o on o."workspaceId" = w.id and o."nameSingular" = 'task'
 where f."objectMetadataId" = o.id
   and f.name = 'outcome'
   and w."databaseSchema" = '__WS__';
