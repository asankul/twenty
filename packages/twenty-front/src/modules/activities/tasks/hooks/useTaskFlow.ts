import { useMemo } from 'react';
import { CoreObjectNameSingular } from 'twenty-shared/types';

import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import {
  buildFlow,
  labelFrom,
  type Outcome,
} from '@/activities/tasks/constants/TaskFlow';

/**
 * Набор кнопок исхода для вида задачи — из метаданных кабинета.
 *
 * Раньше карта жила только в коде, и у каждого кабинета она была общей.
 * Для школы это не годится: там свои статусы и свои исходы, а править
 * формулировку через пересборку образа — слишком дорого.
 *
 * Теперь надписи и цвета берутся из `options` поля `outcome`, а что
 * показывать для какого вида задачи — из его `settings.flow`. Нет
 * настройки — остаётся зашитая карта, поэтому кабинет без неё работает
 * ровно как прежде.
 */
export const useTaskFlow = () => {
  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular: CoreObjectNameSingular.Task,
  });

  const outcomeField = objectMetadataItem?.fields?.find(
    (field) => field.name === 'outcome',
  );

  return useMemo(() => {
    const options = outcomeField?.options;
    const settings = outcomeField?.settings;

    const flowFor = (kind?: string | null): Outcome[] =>
      buildFlow(kind, options, settings);

    return {
      flowFor,
      outcomeIn: (kind: string | null | undefined, value: string) =>
        flowFor(kind).find((item) => item.value === value),
      outcomeLabel: (value?: string | null) => labelFrom(value, options),
    };
  }, [outcomeField?.options, outcomeField?.settings]);
};
