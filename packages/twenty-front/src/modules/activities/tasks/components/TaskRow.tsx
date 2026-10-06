import { styled } from '@linaria/react';
import { t } from '@lingui/core/macro';
import type React from 'react';
import { type ReactNode, useRef, useState } from 'react';

import { ActivityRow } from '@/activities/components/ActivityRow';
import { useTaskFlow } from '@/activities/tasks/hooks/useTaskFlow';
import { TaskComments } from '@/activities/tasks/components/TaskComments';
import { useCompleteTask } from '@/activities/tasks/hooks/useCompleteTask';
import { type Task } from '@/activities/types/Task';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { useOpenRecordInSidePanel } from '@/side-panel/hooks/useOpenRecordInSidePanel';
import { CoreObjectNameSingular } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';
import {
  IconCalendarEvent,
  IconFlag,
  IconMessageCircle,
  IconX,
} from 'twenty-ui/icon';
import { Avatar } from 'twenty-ui/primitives/data-display';
import { Checkbox } from 'twenty-ui/primitives/input';
import { themeCssVariables } from 'twenty-ui/theme';

/**
 * Строка задачи в карточке лида.
 *
 * Правится целиком на месте: название, две даты, исполнитель, отмена.
 * Открывать отдельную карточку ради смены срока — лишние действия там,
 * где хватает одного.
 *
 * Дат две, как в Craft: «когда делать» и «дедлайн». Красным помечается только
 * просроченный дедлайн — пропущенный день начала просрочкой не считается,
 * задача просто переезжает дальше.
 */

const StyledWrapper = styled.div`
  cursor: pointer;
  display: flex;
  flex-direction: column;
  width: 100%;

  &:hover {
    background: ${themeCssVariables.background.transparent.lighter};
  }
`;

// Задачи открывают и в боковой панели, и на всю ширину. В панели правый край
// упирался в границу и дедлайн обрезало, поэтому строка переносится: даты
// уходят под название, а не выдавливают его до трёх букв.
const StyledInner = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${themeCssVariables.spacing[1]};
  justify-content: space-between;
  min-width: 0;
  width: 100%;
`;

const StyledLeftSide = styled.div`
  align-items: center;
  display: flex;
  flex: 1 1 220px;
  gap: ${themeCssVariables.spacing[2]};
  min-width: 0;
`;

const StyledCheckboxSlot = styled.div`
  display: flex;
  flex-shrink: 0;
`;

// Прозрачный список поверх аватара: сам аватар и есть кнопка выбора,
// отдельное поле рядом отнимало бы ширину у названия.
const StyledAssigneeSlot = styled.div`
  display: flex;
  flex-shrink: 0;
  position: relative;
`;

const StyledAssigneeSelect = styled.select`
  cursor: pointer;
  height: 100%;
  left: 0;
  opacity: 0;
  position: absolute;
  top: 0;
  width: 100%;
`;

const StyledTitleInput = styled.input<{ isClosed: boolean }>`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.primary};
  flex: 1;
  font-family: inherit;
  font-size: inherit;
  font-weight: ${themeCssVariables.font.weight.medium};
  min-width: 0;
  outline: none;
  padding: 0;
  text-decoration: ${({ isClosed }) => (isClosed ? 'line-through' : 'none')};
`;

// Пустое поле даты браузер рисует как «dd/mm/yyyy» и занимает им полстроки,
// поэтому само поле прячем, а нажимают по значку с подписью.
const StyledDateButton = styled.button<{ isOverdue: boolean; isSet: boolean }>`
  align-items: center;
  background: transparent;
  border: 0;
  border-radius: ${themeCssVariables.border.radius.sm};
  color: ${({ isOverdue, isSet }) =>
    isOverdue
      ? themeCssVariables.font.color.danger
      : isSet
        ? themeCssVariables.font.color.secondary
        : themeCssVariables.font.color.light};
  cursor: pointer;
  display: inline-flex;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.xs};
  gap: ${themeCssVariables.spacing[1]};
  padding: 2px 4px;
  position: relative;
  white-space: nowrap;

  &:hover {
    background: ${themeCssVariables.background.transparent.light};
  }
`;

const StyledHiddenDateInput = styled.input`
  height: 0;
  left: 0;
  opacity: 0;
  pointer-events: none;
  position: absolute;
  top: 100%;
  width: 0;
`;

const StyledCancelButton = styled.button`
  background: transparent;
  border: 0;
  border-radius: ${themeCssVariables.border.radius.sm};
  color: ${themeCssVariables.font.color.light};
  cursor: pointer;
  display: flex;
  opacity: 0.4;
  padding: 2px;

  &:hover {
    background: ${themeCssVariables.background.transparent.light};
    color: ${themeCssVariables.font.color.secondary};
    opacity: 1;
  }
`;

// Даты и комментарии живут строкой ниже: в одну строку с названием они
// отнимали у него ширину, и в боковой панели название сжималось до трёх букв.
const StyledMetaRow = styled.div`
  align-items: center;
  display: flex;
  flex-wrap: wrap;
  gap: ${themeCssVariables.spacing[1]};
  padding: 0 0 ${themeCssVariables.spacing[1]} ${themeCssVariables.spacing[6]};
`;

const StyledMetaSpacer = styled.div`
  flex: 1;
`;

const StyledCommentsToggle = styled.button`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.tertiary};
  cursor: pointer;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.xxs};
  align-items: center;
  border-radius: ${themeCssVariables.border.radius.sm};
  display: inline-flex;
  gap: ${themeCssVariables.spacing[1]};
  padding: 2px 4px;
  text-align: left;

  &:hover {
    background: ${themeCssVariables.background.transparent.light};
    color: ${themeCssVariables.font.color.secondary};
  }
`;

type Member = {
  id: string;
  name?: { firstName?: string | null; lastName?: string | null } | null;
};

const fullName = (member?: Member | Task['assignee']) =>
  [member?.name?.firstName, member?.name?.lastName]
    .filter(Boolean)
    .join(' ')
    .trim();

// Дата хранится в UTC-полдень: иначе часовой пояс сдвигает день.
const toInputValue = (value?: string | null) =>
  value ? new Date(value).toISOString().slice(0, 10) : '';

const toStoredValue = (value: string) =>
  value === '' ? null : new Date(`${value}T12:00:00Z`).toISOString();

type TaskDateProps = {
  value?: string | null;
  isOverdue: boolean;
  label: string;
  prefix: string;
  icon: ReactNode;
  onChange: (value: string) => void;
};

/**
 * Дата с коротким словом перед ней. Один значок различают только те, кто уже
 * знает разницу между сроком начала и дедлайном; людям, которые видят систему
 * впервые, нужна подпись.
 */
const TaskDate = ({
  value,
  isOverdue,
  label,
  prefix,
  icon,
  onChange,
}: TaskDateProps) => {
  const inputRef = useRef<HTMLInputElement>(null);
  const isSet = isDefined(value) && value !== '';

  const openPicker = () => {
    const input = inputRef.current;

    if (!isDefined(input)) {
      return;
    }

    // showPicker есть не везде; там остаётся обычный фокус.
    if (typeof input.showPicker === 'function') {
      input.showPicker();
    } else {
      input.focus();
    }
  };

  return (
    <StyledDateButton
      type="button"
      isOverdue={isOverdue}
      isSet={isSet}
      title={label}
      onClick={(event) => {
        event.stopPropagation();
        openPicker();
      }}
    >
      {icon}
      {isSet
        ? `${prefix} ${new Date(value as string).toLocaleDateString('ru-RU', {
            day: 'numeric',
            month: 'short',
          })}`
        : prefix}
      <StyledHiddenDateInput
        ref={inputRef}
        type="date"
        value={toInputValue(value)}
        onClick={(event) => event.stopPropagation()}
        onChange={(event) => onChange(event.target.value)}
      />
    </StyledDateButton>
  );
};

const StyledOutcomeRow = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${themeCssVariables.spacing[1]};
  padding: ${themeCssVariables.spacing[0]} ${themeCssVariables.spacing[4]}
    ${themeCssVariables.spacing[2]};
`;

const StyledOutcomeButton = styled.button<{ isChosen: boolean }>`
  background: ${({ isChosen }) =>
    isChosen ? 'var(--pill-bg)' : themeCssVariables.background.transparent.light};
  border: 1px solid
    ${({ isChosen }) => (isChosen ? 'var(--pill-bg)' : 'transparent')};
  border-radius: ${themeCssVariables.border.radius.sm};
  color: ${({ isChosen }) =>
    isChosen ? 'var(--pill-fg)' : themeCssVariables.font.color.secondary};
  cursor: pointer;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.xs};
  font-weight: ${themeCssVariables.font.weight.medium};
  padding: ${themeCssVariables.spacing[1]} ${themeCssVariables.spacing[2]};
  white-space: nowrap;

  &:hover {
    background: var(--pill-bg);
    color: var(--pill-fg);
  }
`;

export const TaskRow = ({ task }: { task: Task }) => {
  const { flowFor } = useTaskFlow();
  const { updateOneRecord } = useUpdateOneRecord();
  const { openRecordInSidePanel } = useOpenRecordInSidePanel();
  const [title, setTitle] = useState(task.title ?? '');
  const [areCommentsOpen, setAreCommentsOpen] = useState(false);

  const isClosed = task.status === 'DONE' || task.status === 'CANCELLED';
  const isOverdue =
    isDefined(task.dueAt) && new Date(task.dueAt) < new Date() && !isClosed;

  const { completeTask } = useCompleteTask(task);

  const update = (input: Record<string, unknown>) =>
    updateOneRecord({
      objectNameSingular: CoreObjectNameSingular.Task,
      idToUpdate: task.id,
      updateOneRecordInput: input,
    });

  const saveTitle = async () => {
    if (title !== (task.title ?? '')) {
      await update({ title });
    }
  };

  // Права уже сужают выдачу: старший брокер получит свою команду
  // и безкомандных, чужих в списке не будет.
  const { records: members } = useFindManyRecords<Member>({
    objectNameSingular: 'workspaceMember',
    limit: 200,
  });

  // Нужна только цифра, поэтому берём totalCount: сами комментарии
  // грузятся, лишь когда ленту разворачивают.
  const { totalCount: commentCount } = useFindManyRecords({
    objectNameSingular: 'taskComment',
    filter: { taskId: { eq: task.id } },
    limit: 1,
  });

  const assigneeName =
    fullName(task.assignee) ||
    fullName(members.find((member) => member.id === task.assigneeId));

  return (
    <StyledWrapper
      onClick={() =>
        openRecordInSidePanel({
          recordId: task.id,
          objectNameSingular: CoreObjectNameSingular.Task,
        })
      }
    >
      <ActivityRow disabled>
        <StyledInner>
          <StyledLeftSide>
            <StyledCheckboxSlot onClick={(event) => event.stopPropagation()}>
              <Checkbox
                checked={task.status === 'DONE'}
                shape="round"
                onCheckedChange={completeTask}
              />
            </StyledCheckboxSlot>

            <StyledAssigneeSlot title={assigneeName || t`No assignee`}>
              <Avatar
                src={task.assignee?.avatarUrl}
                name={assigneeName === '' ? '?' : assigneeName}
                size="sm"
                shape="circle"
              />
              <StyledAssigneeSelect
                value={task.assigneeId ?? ''}
                aria-label={t`Assignee`}
                onClick={(event) => event.stopPropagation()}
                onChange={(event) =>
                  update({
                    assigneeId:
                      event.target.value === '' ? null : event.target.value,
                  })
                }
              >
                <option value="">{t`No assignee`}</option>
                {members.map((member) => (
                  <option key={member.id} value={member.id}>
                    {fullName(member)}
                  </option>
                ))}
              </StyledAssigneeSelect>
            </StyledAssigneeSlot>

            <StyledTitleInput
              isClosed={isClosed}
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
          </StyledLeftSide>
        </StyledInner>
      </ActivityRow>

      <StyledMetaRow>
        <StyledCommentsToggle
          onClick={(event) => {
            event.stopPropagation();
            setAreCommentsOpen(!areCommentsOpen);
          }}
        >
          <IconMessageCircle size={14} />
          {areCommentsOpen
            ? t`Hide comments`
            : isDefined(commentCount) && commentCount > 0
              ? t`Comments (${commentCount})`
              : t`Comments`}
        </StyledCommentsToggle>

        <TaskDate
          value={task.scheduledAt}
          isOverdue={false}
          label={t`When to start`}
          prefix={t`start`}
          icon={<IconCalendarEvent size={14} />}
          onChange={(value) => update({ scheduledAt: toStoredValue(value) })}
        />
        <TaskDate
          value={task.dueAt}
          isOverdue={isOverdue}
          label={t`Deadline`}
          prefix={t`due`}
          icon={<IconFlag size={14} />}
          onChange={(value) => update({ dueAt: toStoredValue(value) })}
        />

        <StyledMetaSpacer />

        <StyledCancelButton
          type="button"
          title={t`Mark as cancelled`}
          onClick={(event) => {
            event.stopPropagation();
            update({ status: 'CANCELLED' });
          }}
        >
          <IconX size={14} />
        </StyledCancelButton>
      </StyledMetaRow>
      {!isClosed && (
      <StyledOutcomeRow>
        {flowFor(task.kind).map((outcome) => (
          <StyledOutcomeButton
            key={outcome.value}
            type="button"
            title={outcome.label}
            isChosen={task.outcome === outcome.value}
            style={
              {
                '--pill-bg': `var(--t-tag-background-${outcome.color})`,
                '--pill-fg': `var(--t-tag-text-${outcome.color})`,
              } as React.CSSProperties
            }
            onClick={(event) => {
              event.stopPropagation();
              update({ outcome: outcome.value });
              setAreCommentsOpen(true);
            }}
          >
            {outcome.label}
          </StyledOutcomeButton>
        ))}
      </StyledOutcomeRow>
      )}

      {areCommentsOpen && (
        <div onClick={(event) => event.stopPropagation()}>
          <TaskComments taskId={task.id} />
        </div>
      )}
    </StyledWrapper>
  );
};
