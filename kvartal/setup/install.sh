#!/usr/bin/env bash
#
# Установка настройки кабинета на схему Twenty.
#
#   ./install.sh workspace_xxxxxxxx            # всё по порядку
#   ./install.sh workspace_xxxxxxxx 03_flow    # только один шаг
#
# Схема должна уже существовать: её создаёт сам Twenty при активации
# кабинета. Мы ставим поверх только то, чего в стандартной поставке нет.
#
# Соединение берётся из переменных окружения, чтобы скрипт одинаково
# работал и с боевой базой через ssh, и с проверочной локально:
#
#   PSQL="docker exec -i twenty-db-1 psql -U postgres -d default"
#
set -euo pipefail

WS="${1:-}"
ONLY="${2:-}"

if [[ -z "$WS" ]]; then
  echo "Укажите схему кабинета: ./install.sh workspace_xxxxxxxx" >&2
  exit 1
fi

if [[ ! "$WS" =~ ^workspace_[a-z0-9]+$ ]]; then
  echo "Непохоже на схему кабинета: $WS" >&2
  echo "Ожидается workspace_ и дальше буквы с цифрами." >&2
  exit 1
fi

PSQL="${PSQL:-psql}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

shopt -s nullglob
steps=("$HERE"/[0-9][0-9]_*.sql)
shopt -u nullglob

if [[ ${#steps[@]} -eq 0 ]]; then
  echo "Нечего ставить: рядом нет файлов вида 01_*.sql" >&2
  exit 1
fi

for step in "${steps[@]}"; do
  name="$(basename "$step" .sql)"

  if [[ -n "$ONLY" && "$name" != "$ONLY" ]]; then
    continue
  fi

  echo "→ $name"

  # Весь шаг одной транзакцией: половина установленной настройки хуже,
  # чем не установленная. ON_ERROR_STOP, иначе psql молча идёт дальше.
  {
    echo "begin;"
    sed "s/__WS__/$WS/g" "$step"
    echo "commit;"
  } | $PSQL -v ON_ERROR_STOP=1 --quiet

  echo "  готово"
done

echo "Установка завершена для схемы $WS"
