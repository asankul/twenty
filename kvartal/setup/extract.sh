#!/usr/bin/env bash
#
# Снимает настройку кабинета с живой базы в файлы установщика.
#
#   PSQL="ssh -i ~/.ssh/twenty-deploy root@HOST docker exec -i twenty-db-1 psql -U postgres -d default" \
#   ./extract.sh workspace_d23hh7a34snje4p8trbenc2ot
#
# Запросы уходят в stdin, а не через -c: по дороге к боевой базе стоит
# второй шелл (ssh), и он бы разорвал многострочный SQL на словах.
# Поэтому docker exec нужен с флагом -i.
#
# Писать установщик по памяти нельзя: то, что стоит на проде, собиралось
# больше месяца десятками правок. Единственный достоверный источник —
# сама база, поэтому файлы генерируются, а не пишутся руками.
#
# Имя схемы заменяется на __WS__ — install.sh подставит нужное. psql свои
# переменные внутрь тел функций не подставляет, они в долларовых кавычках.
set -euo pipefail

WS="${1:-}"
if [[ -z "$WS" ]]; then
  echo "Укажите схему, с которой снимаем: ./extract.sh workspace_xxxxxxxx" >&2
  exit 1
fi

PSQL="${PSQL:-psql}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

q() { printf '%s\n' "$1" | $PSQL -At; }

echo "→ функции ops"
# merge_opportunity не берём: это разовый инструмент слияния дублей,
# к настройке кабинета он отношения не имеет.
# task_weight идёт первой — на неё опирается task_set_priority.
funcs=$(q "
select string_agg(def || ';', chr(10)||chr(10) order by ord, nm) from (
  select 1 as ord, p.proname as nm, pg_get_functiondef(p.oid) as def
    from pg_proc p join pg_namespace n on n.oid = p.pronamespace
   where n.nspname = 'ops' and p.proname = 'task_weight'
  union all
  select 2, p.proname, pg_get_functiondef(p.oid)
    from pg_proc p join pg_namespace n on n.oid = p.pronamespace
   where n.nspname = 'ops' and p.proname not in ('task_weight', 'merge_opportunity')
) x;")

echo "→ триггеры схемы"
trigs=$(q "
select string_agg(
         'drop trigger if exists ' || quote_ident(t.tgname) ||
         ' on ' || quote_ident(n.nspname) || '.' || quote_ident(c.relname) || ';' || chr(10) ||
         pg_get_triggerdef(t.oid) || ';',
         chr(10)||chr(10) order by c.relname, t.tgname)
  from pg_trigger t
  join pg_class c on c.oid = t.tgrelid
  join pg_namespace n on n.oid = c.relnamespace
 where n.nspname = '$WS' and not t.tgisinternal;")

{
  cat <<'HEADER'
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

HEADER
  printf '%s\n\n' "$funcs"
  printf '%s\n' "$trigs"
} | sed "s/$WS/__WS__/g" > "$HERE/03_flow.sql"

echo "  03_flow.sql: функций $(grep -c 'CREATE OR REPLACE FUNCTION' "$HERE/03_flow.sql"), триггеров $(grep -c 'CREATE TRIGGER' "$HERE/03_flow.sql")"

if grep -q "$WS" "$HERE/03_flow.sql"; then
  echo "ОШИБКА: имя боевой схемы осталось в файле" >&2
  exit 1
fi

echo "Снято."
