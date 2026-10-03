import { styled } from '@linaria/react';
import { RecordBoardContext } from '@/object-record/record-board/contexts/RecordBoardContext';
import { RECORD_BOARD_CARD_INPUT_ID_PREFIX } from '@/object-record/record-board/record-board-card/constants/RecordBoardCardInputIdPrefix';
import { RecordBoardCardContext } from '@/object-record/record-board/record-board-card/contexts/RecordBoardCardContext';
import { recordBoardCardHoverPositionComponentState } from '@/object-record/record-board/record-board-card/states/recordBoardCardHoverPositionComponentState';
import { RecordCardBodyContainer } from '@/object-record/record-card/components/RecordCardBodyContainer';
import { visibleRecordFieldsComponentSelector } from '@/object-record/record-field/states/visibleRecordFieldsComponentSelector';
import {
  FieldContext,
  type RecordUpdateHook,
  type RecordUpdateHookParams,
} from '@/object-record/record-field/ui/contexts/FieldContext';
import { RecordFieldComponentInstanceContext } from '@/object-record/record-field/ui/states/contexts/RecordFieldComponentInstanceContext';
import { useRecordIndexContextOrThrow } from '@/object-record/record-index/contexts/RecordIndexContext';
import { RecordInlineCell } from '@/object-record/record-inline-cell/components/RecordInlineCell';
import { getRecordFieldInputInstanceId } from '@/object-record/utils/getRecordFieldInputId';
import { useAtomComponentSelectorValue } from '@/ui/utilities/state/jotai/hooks/useAtomComponentSelectorValue';
import { useSetAtomComponentState } from '@/ui/utilities/state/jotai/hooks/useSetAtomComponentState';
import { useContext } from 'react';
import { isDefined } from 'twenty-shared/utils';

/**
 * Поле на карточке доски — просто строка текста.
 *
 * Раньше каждое поле перехватывало клик и открывалось на правку: куда ни
 * ткни, попадаешь в поле, а карточка не открывается. Доска нужна, чтобы
 * посмотреть и открыть; править — внутри карточки или в очереди.
 */
const StyledFieldLine = styled.div`
  display: flex;
  flex-direction: row;
  pointer-events: none;
  width: 100%;
`;

export const RecordBoardCardBody = () => {
  const { recordId, isDragOverlay } = useContext(
    RecordBoardCardContext,
  );

  const { updateOneRecord } = useContext(RecordBoardContext);

  const {
    labelIdentifierFieldMetadataItem,
    fieldMetadataItemByFieldMetadataItemId,
    fieldDefinitionByFieldMetadataItemId,
  } = useRecordIndexContextOrThrow();

  const useUpdateOneRecordHook: RecordUpdateHook = () => {
    const updateEntity = ({ variables }: RecordUpdateHookParams) => {
      updateOneRecord?.({
        idToUpdate: variables.where.id as string,
        updateOneRecordInput: variables.updateOneRecordInput,
      });
    };

    return [updateEntity, { loading: false }];
  };

  const visibleRecordFields = useAtomComponentSelectorValue(
    visibleRecordFieldsComponentSelector,
  );

  const visibleRecordFieldsExceptLabelIdentifier = visibleRecordFields.filter(
    (recordField) =>
      recordField.fieldMetadataItemId !== labelIdentifierFieldMetadataItem?.id,
  );

  const setRecordBoardCardHoverPosition = useSetAtomComponentState(
    recordBoardCardHoverPositionComponentState,
  );

  const handleMouseEnter = (index: number) => {
    setRecordBoardCardHoverPosition(index);
  };

  return (
    <RecordCardBodyContainer>
      {visibleRecordFieldsExceptLabelIdentifier.map((recordField, index) => {
        const correspondingFieldDefinition =
          fieldDefinitionByFieldMetadataItemId[recordField.fieldMetadataItemId];
        const fieldMetadataItem =
          fieldMetadataItemByFieldMetadataItemId[
            recordField.fieldMetadataItemId
          ];

        if (
          !isDefined(correspondingFieldDefinition) ||
          !isDefined(fieldMetadataItem)
        ) {
          return null;
        }

        return (
          <StyledFieldLine key={recordField.fieldMetadataItemId}>
            <FieldContext.Provider
              value={{
                recordId,
                maxWidth: 156,
                isLabelIdentifier: false,
                // На доске поля не правятся ни у кого: клик должен
                // открывать карточку, а не редактор поля.
                isRecordFieldReadOnly: true,
                fieldDefinition: correspondingFieldDefinition,
                useUpdateRecord: useUpdateOneRecordHook,
                isDisplayModeFixHeight: true,
                triggerEvent: 'CLICK',
                anchorId: isDragOverlay
                  ? undefined
                  : `${RECORD_BOARD_CARD_INPUT_ID_PREFIX}-${recordId}-${correspondingFieldDefinition.metadata.fieldName}`,
                onMouseEnter: () => handleMouseEnter(index),
              }}
            >
              <RecordFieldComponentInstanceContext.Provider
                value={{
                  instanceId: getRecordFieldInputInstanceId({
                    recordId,
                    fieldName: correspondingFieldDefinition.metadata.fieldName,
                    prefix: RECORD_BOARD_CARD_INPUT_ID_PREFIX,
                  }),
                }}
              >
                <RecordInlineCell
                  instanceIdPrefix={RECORD_BOARD_CARD_INPUT_ID_PREFIX}
                />
              </RecordFieldComponentInstanceContext.Provider>
            </FieldContext.Provider>
          </StyledFieldLine>
        );
      })}
    </RecordCardBodyContainer>
  );
};
