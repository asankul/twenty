import { styled } from '@linaria/react';
import { t } from '@lingui/core/macro';
import { useState } from 'react';

import { getActivitySummary } from '@/activities/utils/getActivitySummary';

import { ActivityRow } from '@/activities/components/ActivityRow';
import { useActivityFieldComponentInstanceId } from '@/activities/hooks/useActivityFieldComponentInstanceId';
import { useCompleteTask } from '@/activities/tasks/hooks/useCompleteTask';
import { type Task } from '@/activities/types/Task';
import { StopPropagationContainer } from '@/object-record/record-board/record-board-card/components/StopPropagationContainer';
import { RecordFieldsScopeContextProvider } from '@/object-record/record-field-list/contexts/RecordFieldsScopeContext';
import { FieldContextProvider } from '@/object-record/record-field/ui/components/FieldContextProvider';
import { useObjectMorphJunctionConfigOrThrow } from '@/object-record/record-field/ui/hooks/useObjectMorphJunctionConfigOrThrow';
import { RecordFieldComponentInstanceContext } from '@/object-record/record-field/ui/states/contexts/RecordFieldComponentInstanceContext';
import { RecordInlineCell } from '@/object-record/record-inline-cell/components/RecordInlineCell';
import { getRecordFieldInputInstanceId } from '@/object-record/utils/getRecordFieldInputId';
import { TaskComments } from '@/activities/tasks/components/TaskComments';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { useOpenRecordInSidePanel } from '@/side-panel/hooks/useOpenRecordInSidePanel';
import { CoreObjectNameSingular } from 'twenty-shared/types';
import { OverflowingTextWithTooltip } from 'twenty-ui/primitives/typography';
import { Checkbox } from 'twenty-ui/primitives/input';
import { themeCssVariables } from 'twenty-ui/theme';

const StyledTaskBody = styled.div`
  color: ${themeCssVariables.font.color.tertiary};
  display: flex;
  max-width: calc(80% - ${themeCssVariables.spacing[2]});
  overflow: hidden;
  padding-bottom: 1px;
  text-overflow: ellipsis;
`;

const StyledTitleInput = styled.input<{
  completed: boolean;
}>`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.primary};
  flex: 1;
  font-family: inherit;
  font-size: inherit;
  font-weight: ${themeCssVariables.font.weight.medium};
  min-width: 0;
  outline: none;
  padding: 0 ${themeCssVariables.spacing[2]};
  text-decoration: ${({ completed }) => (completed ? 'line-through' : 'none')};
`;

const StyledWrapper = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
`;

const StyledCommentsToggle = styled.button`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.tertiary};
  cursor: pointer;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.xxs};
  padding: 0 0 ${themeCssVariables.spacing[1]} ${themeCssVariables.spacing[6]};
  text-align: left;

  &:hover {
    color: ${themeCssVariables.font.color.secondary};
  }
`;

const StyledAssignee = styled.span`
  align-items: center;
  background: ${themeCssVariables.background.transparent.light};
  border-radius: ${themeCssVariables.border.radius.sm};
  color: ${themeCssVariables.font.color.secondary};
  display: inline-flex;
  flex-shrink: 0;
  font-size: ${themeCssVariables.font.size.xs};
  margin-right: ${themeCssVariables.spacing[2]};
  padding: 1px 6px;
  white-space: nowrap;
`;

const StyledTaskTitle = styled.div<{
  completed: boolean;
}>`
  align-items: center;
  color: ${themeCssVariables.font.color.primary};
  font-weight: ${themeCssVariables.font.weight.medium};
  overflow: hidden;
  padding: 0 ${themeCssVariables.spacing[2]};
  padding-bottom: 1px;
  text-decoration: ${({ completed }) => (completed ? 'line-through' : 'none')};
  text-overflow: ellipsis;

  white-space: nowrap;
`;

const StyledDueDateCell = styled.div`
  flex-shrink: 0;
  margin-right: ${themeCssVariables.spacing[2]};
  min-width: 96px;
`;

const StyledRightSideContainer = styled.div`
  align-items: center;
  display: inline-flex;
  max-width: 50%;
`;

const StyledActivityTargetsContainer = styled.div`
  overflow: clip;
  width: 100%;
`;

const StyledPlaceholder = styled.div`
  color: ${themeCssVariables.font.color.light};
`;

const StyledLeftSideContainer = styled.div`
  align-items: center;
  display: inline-flex;
  display: flex;
  flex: 1;
  overflow: hidden;
`;

const StyledCheckboxContainer = styled.div`
  display: flex;
`;

export const TaskRow = ({ task }: { task: Task }) => {
  const { openRecordInSidePanel } = useOpenRecordInSidePanel();
  const { updateOneRecord } = useUpdateOneRecord();
  const [title, setTitle] = useState(task.title ?? '');
  const [areCommentsOpen, setAreCommentsOpen] = useState(false);

  const saveTitle = async () => {
    if (title === (task.title ?? '')) {
      return;
    }

    await updateOneRecord({
      objectNameSingular: CoreObjectNameSingular.Task,
      idToUpdate: task.id,
      updateOneRecordInput: { title },
    });
  };

  const assigneeName = [
    task.assignee?.name?.firstName,
    task.assignee?.name?.lastName,
  ]
    .filter(Boolean)
    .join(' ')
    .trim();

  const body = getActivitySummary(task?.bodyV2?.blocknote ?? null);

  const { completeTask } = useCompleteTask(task);

  const junctionFieldName = useObjectMorphJunctionConfigOrThrow({
    objectNameSingular: CoreObjectNameSingular.Task,
  }).junctionField.name;

  const instanceIdPrefix =
    useActivityFieldComponentInstanceId('task-row-targets');
  const componentInstanceId = getRecordFieldInputInstanceId({
    recordId: task.id,
    fieldName: junctionFieldName,
    prefix: instanceIdPrefix,
  });

  const dueAtInstanceIdPrefix =
    useActivityFieldComponentInstanceId('task-row-due-at');
  const dueAtComponentInstanceId = getRecordFieldInputInstanceId({
    recordId: task.id,
    fieldName: 'dueAt',
    prefix: dueAtInstanceIdPrefix,
  });

  return (
    <StyledWrapper>
    <ActivityRow
      onClick={() => {
        openRecordInSidePanel({
          recordId: task.id,
          objectNameSingular: CoreObjectNameSingular.Task,
        });
      }}
    >
      <StyledLeftSideContainer>
        <StyledCheckboxContainer
          onClick={(e) => {
            e.stopPropagation();
          }}
        >
          <Checkbox
            checked={task.status === 'DONE'}
            shape={'round'}
            onCheckedChange={completeTask}
          />
        </StyledCheckboxContainer>
        <StyledTitleInput
          completed={task.status === 'DONE'}
          value={title}
          placeholder={t`Task title`}
          onClick={(event) => event.stopPropagation()}
          onChange={(event) => setTitle(event.target.value)}
          onBlur={saveTitle}
          onKeyDown={(event) => {
            if (event.key === 'Enter') {
              event.currentTarget.blur();
            }

            if (event.key === 'Escape') {
              setTitle(task.title ?? '');
              event.currentTarget.blur();
            }
          }}
        />
        <StyledTaskBody>
          <OverflowingTextWithTooltip text={body} />
        </StyledTaskBody>
      </StyledLeftSideContainer>
      <StyledRightSideContainer>
        {assigneeName !== '' && <StyledAssignee>{assigneeName}</StyledAssignee>}
        <StyledDueDateCell>
          <FieldContextProvider
            objectNameSingular={CoreObjectNameSingular.Task}
            objectRecordId={task.id}
            fieldMetadataName="dueAt"
            fieldPosition={0}
            showLabel={false}
            isDisplayModeFixHeight
          >
            <RecordFieldsScopeContextProvider
              value={{
                scopeInstanceId: task.id,
              }}
            >
              <StopPropagationContainer>
                <RecordFieldComponentInstanceContext.Provider
                  value={{ instanceId: dueAtComponentInstanceId }}
                >
                  <RecordInlineCell
                    instanceIdPrefix={dueAtInstanceIdPrefix}
                  />
                </RecordFieldComponentInstanceContext.Provider>
              </StopPropagationContainer>
            </RecordFieldsScopeContextProvider>
          </FieldContextProvider>
        </StyledDueDateCell>
        {
          <StyledActivityTargetsContainer>
            <FieldContextProvider
              objectNameSingular={CoreObjectNameSingular.Task}
              objectRecordId={task.id}
              fieldMetadataName={junctionFieldName}
              fieldPosition={0}
              showLabel={false}
              maxWidth={200}
              isDisplayModeFixHeight
            >
              <RecordFieldsScopeContextProvider
                value={{
                  scopeInstanceId: task.id,
                }}
              >
                <StopPropagationContainer>
                  <RecordFieldComponentInstanceContext.Provider
                    value={{ instanceId: componentInstanceId }}
                  >
                    <RecordInlineCell instanceIdPrefix={instanceIdPrefix} />
                  </RecordFieldComponentInstanceContext.Provider>
                </StopPropagationContainer>
              </RecordFieldsScopeContextProvider>
            </FieldContextProvider>
          </StyledActivityTargetsContainer>
        }
      </StyledRightSideContainer>
    </ActivityRow>
      <StyledCommentsToggle
        onClick={(event) => {
          event.stopPropagation();
          setAreCommentsOpen(!areCommentsOpen);
        }}
      >
        {areCommentsOpen ? t`Hide comments` : t`Comments`}
      </StyledCommentsToggle>
      {areCommentsOpen && <TaskComments taskId={task.id} />}
    </StyledWrapper>
  );
};
