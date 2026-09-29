import { useAtomValue } from 'jotai';
import { useCallback } from 'react';

import { type ActivityTargetableObject } from '@/activities/types/ActivityTargetableEntity';
import { useObjectMetadataItems } from '@/object-metadata/hooks/useObjectMetadataItems';
import { useObjectMorphJunctionConfigOrThrow } from '@/object-record/record-field/ui/hooks/useObjectMorphJunctionConfigOrThrow';
import { findTargetFieldInfo } from '@/object-record/record-field/ui/utils/junction/findTargetFieldInfo';
import { useCreateManyRecords } from '@/object-record/hooks/useCreateManyRecords';
import { useCreateOneRecord } from '@/object-record/hooks/useCreateOneRecord';
import { recordStoreFamilyState } from '@/object-record/record-store/states/recordStoreFamilyState';
import { CoreObjectNameSingular } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';

/**
 * Создаёт задачу прямо в списке карточки и привязывает её к записи.
 *
 * Штатный путь открывает отдельное окно: чтобы записать «перезвонить в
 * четверг», нужно четыре действия вместо одного. Здесь задача появляется
 * по Enter — список ведут во время разговора, а не после него.
 *
 * Привязка повторяет ту же схему, что и окно создания: сначала задача,
 * потом запись связи с лидом. Без второго шага задача повиснет ничьей.
 *
 * Исполнитель не спрашивается: за задачу по лиду отвечает тот, за кем
 * закреплён сам лид. Выбирать его вручную — лишний шаг с единственным
 * правильным ответом.
 */
export const useCreateTaskInline = (
  targetableObject: ActivityTargetableObject,
) => {
  const { createOneRecord: createOneTask } = useCreateOneRecord({
    objectNameSingular: CoreObjectNameSingular.Task,
    shouldMatchRootQueryFilter: true,
  });

  const { objectMetadataItems } = useObjectMetadataItems();

  const morphJunctionConfig = useObjectMorphJunctionConfigOrThrow({
    objectNameSingular: CoreObjectNameSingular.Task,
  });

  const { createManyRecords: createTaskTargets } = useCreateManyRecords({
    objectNameSingular: morphJunctionConfig.junctionObjectMetadata.nameSingular,
    shouldMatchRootQueryFilter: true,
  });

  const targetRecord = useAtomValue(
    recordStoreFamilyState.atomFamily(targetableObject.id),
  );
  const assigneeId =
    (targetRecord as { ownerId?: string | null } | null)?.ownerId ?? undefined;

  const createTask = useCallback(
    async (title: string) => {
      const trimmedTitle = title.trim();

      if (trimmedTitle === '') {
        return;
      }

      const task = await createOneTask({
        title: trimmedTitle,
        status: 'TODO',
        position: 'last',
        ...(isDefined(assigneeId) ? { assigneeId } : {}),
      });

      const { junctionObjectMetadata, sourceJoinColumnName } =
        morphJunctionConfig;

      const targetObjectMetadata = objectMetadataItems.find(
        (item) =>
          item.nameSingular === targetableObject.targetObjectNameSingular,
      );

      const targetFieldInfo = findTargetFieldInfo(
        junctionObjectMetadata.fields,
        targetObjectMetadata?.id ?? '',
        objectMetadataItems,
      );

      if (!isDefined(targetFieldInfo?.joinColumnName)) {
        return;
      }

      await createTaskTargets({
        recordsToCreate: [
          {
            [sourceJoinColumnName]: task.id,
            [targetFieldInfo.joinColumnName]: targetableObject.id,
          },
        ],
        upsert: true,
      });
    },
    [
      assigneeId,
      createOneTask,
      createTaskTargets,
      morphJunctionConfig,
      objectMetadataItems,
      targetableObject,
    ],
  );

  return { createTask };
};
