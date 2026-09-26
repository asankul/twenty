import { styled } from '@linaria/react';
import { useMemo, useState } from 'react';
import { themeCssVariables } from 'twenty-ui/theme';

import { useCreateOneRecord } from '@/object-record/hooks/useCreateOneRecord';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';

/**
 * Список задач одной лентой.
 *
 * Таблица и доска требуют открыть запись, чтобы отметить сделанное или
 * поменять срок. Здесь всё в строке: галочка закрывает задачу, срок и
 * исполнитель меняются на месте, Enter заводит следующую — так список
 * ведут во время разговора, а не после него.
 */

type Member = {
  id: string;
  name?: { firstName?: string | null; lastName?: string | null } | null;
};

type Task = {
  id: string;
  title?: string | null;
  status?: string | null;
  dueAt?: string | null;
  assigneeId?: string | null;
};

const DONE = 'DONE';
const TODO = 'TODO';

const StyledPage = styled.div`
  background: ${themeCssVariables.background.secondary};
  display: flex;
  flex: 1;
  flex-direction: column;
  overflow: auto;
  padding: 28px 32px;
`;

const StyledTitle = styled.h1`
  color: ${themeCssVariables.font.color.primary};
  font-size: 20px;
  font-weight: 600;
  margin: 0 0 20px;
`;

const StyledGroup = styled.section`
  margin-bottom: 22px;
  max-width: 820px;
`;

const StyledGroupName = styled.h2<{ isLate: boolean }>`
  color: ${({ isLate }) =>
    isLate ? themeCssVariables.color.red : themeCssVariables.font.color.secondary};
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.04em;
  margin: 0 0 8px;
  text-transform: uppercase;
`;

const StyledRow = styled.div<{ isDone: boolean }>`
  align-items: flex-start;
  border-bottom: 1px solid ${themeCssVariables.border.color.light};
  display: flex;
  gap: 10px;
  opacity: ${({ isDone }) => (isDone ? 0.45 : 1)};
  padding: 7px 4px;
`;

const StyledCheck = styled.button<{ isDone: boolean }>`
  background: ${({ isDone }) =>
    isDone ? themeCssVariables.color.blue : 'transparent'};
  border: 1.5px solid
    ${({ isDone }) =>
      isDone ? themeCssVariables.color.blue : themeCssVariables.border.color.strong};
  border-radius: 5px;
  color: #fff;
  cursor: pointer;
  flex-shrink: 0;
  font-size: 11px;
  height: 17px;
  line-height: 1;
  margin-top: 3px;
  padding: 0;
  width: 17px;
`;

const StyledBody = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: 3px;
  min-width: 0;
`;

const StyledTitleInput = styled.input<{ isDone: boolean }>`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.primary};
  font-family: inherit;
  font-size: 14px;
  outline: none;
  padding: 0;
  text-decoration: ${({ isDone }) => (isDone ? 'line-through' : 'none')};
  width: 100%;
`;

const StyledMeta = styled.div`
  align-items: center;
  display: flex;
  gap: 10px;
`;

const StyledChip = styled.span`
  background: ${themeCssVariables.background.transparent.light};
  border-radius: 4px;
  color: ${themeCssVariables.font.color.secondary};
  font-size: 11px;
  padding: 1px 6px;
`;

const StyledDue = styled.span<{ isLate: boolean }>`
  color: ${({ isLate }) =>
    isLate ? themeCssVariables.color.red : themeCssVariables.font.color.tertiary};
  font-size: 11px;
`;

const StyledPicker = styled.select`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.tertiary};
  font-family: inherit;
  font-size: 11px;
  outline: none;
`;

const StyledAdd = styled.button`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.tertiary};
  cursor: pointer;
  font-family: inherit;
  font-size: 13px;
  padding: 8px 4px;
  text-align: left;
`;

const startOfDay = (date: Date) =>
  new Date(date.getFullYear(), date.getMonth(), date.getDate());

const describeDue = (value?: string | null) => {
  if (!value) return null;
  const due = new Date(value);
  const today = startOfDay(new Date());
  const day = startOfDay(due);
  const diff = Math.round((day.getTime() - today.getTime()) / 86400000);
  if (diff === 0) return 'Сегодня';
  if (diff === 1) return 'Завтра';
  if (diff === -1) return 'Вчера';
  return due.toLocaleDateString('ru-RU', { day: 'numeric', month: 'short' });
};

export const TaskBoardPage = () => {
  const [draft, setDraft] = useState<string | null>(null);

  const { records: tasks, loading } = useFindManyRecords<Task>({
    objectNameSingular: 'task',
    limit: 200,
  });

  const { records: members } = useFindManyRecords<Member>({
    objectNameSingular: 'workspaceMember',
    limit: 100,
  });

  const { updateOneRecord } = useUpdateOneRecord();
  const { createOneRecord } = useCreateOneRecord<Task>({
    objectNameSingular: 'task',
  });

  const memberName = useMemo(() => {
    const map = new Map<string, string>();
    members.forEach((member) =>
      map.set(
        member.id,
        [member.name?.firstName, member.name?.lastName]
          .filter(Boolean)
          .join(' ')
          .trim(),
      ),
    );
    return map;
  }, [members]);

  const groups = useMemo(() => {
    const today = startOfDay(new Date()).getTime();
    const buckets: Record<string, Task[]> = {
      Просрочено: [],
      Сегодня: [],
      Завтра: [],
      Позже: [],
      'Без срока': [],
      Выполнено: [],
    };
    tasks.forEach((task) => {
      if (task.status === DONE) return buckets['Выполнено'].push(task);
      if (!task.dueAt) return buckets['Без срока'].push(task);
      const day = startOfDay(new Date(task.dueAt)).getTime();
      if (day < today) return buckets['Просрочено'].push(task);
      if (day === today) return buckets['Сегодня'].push(task);
      if (day === today + 86400000) return buckets['Завтра'].push(task);
      buckets['Позже'].push(task);
    });
    return buckets;
  }, [tasks]);

  const patch = (task: Task, input: Partial<Task>) =>
    updateOneRecord({
      objectNameSingular: 'task',
      idToUpdate: task.id,
      updateOneRecordInput: input,
    });

  const addTask = async (title: string) => {
    const text = title.trim();
    if (text === '') return;
    await createOneRecord({ title: text, status: TODO });
    setDraft('');
  };

  const row = (task: Task) => {
    const isDone = task.status === DONE;
    const due = describeDue(task.dueAt);
    const isLate =
      !isDone &&
      Boolean(task.dueAt) &&
      startOfDay(new Date(task.dueAt as string)).getTime() <
        startOfDay(new Date()).getTime();

    return (
      <StyledRow key={task.id} isDone={isDone}>
        <StyledCheck
          isDone={isDone}
          title={isDone ? 'Вернуть в работу' : 'Отметить выполненной'}
          onClick={() => patch(task, { status: isDone ? TODO : DONE })}
        >
          {isDone ? '✓' : ''}
        </StyledCheck>
        <StyledBody>
          <StyledTitleInput
            isDone={isDone}
            defaultValue={task.title ?? ''}
            onBlur={(event) => {
              if (event.target.value !== (task.title ?? '')) {
                patch(task, { title: event.target.value });
              }
            }}
            onKeyDown={(event) => {
              if (event.key === 'Enter') {
                event.currentTarget.blur();
                setDraft('');
              }
            }}
          />
          <StyledMeta>
            <StyledPicker
              value={task.assigneeId ?? ''}
              onChange={(event) =>
                patch(task, { assigneeId: event.target.value || null })
              }
            >
              <option value="">без исполнителя</option>
              {members.map((member) => (
                <option key={member.id} value={member.id}>
                  {memberName.get(member.id)}
                </option>
              ))}
            </StyledPicker>
            {task.assigneeId !== null && task.assigneeId !== undefined && (
              <StyledChip>{memberName.get(task.assigneeId)}</StyledChip>
            )}
            {due !== null && (
              <StyledDue isLate={isLate}>
                {isLate ? '🚩 ' : '📅 '}
                {due}
              </StyledDue>
            )}
          </StyledMeta>
        </StyledBody>
      </StyledRow>
    );
  };

  if (loading) {
    return (
      <StyledPage>
        <StyledTitle>Задачи</StyledTitle>
      </StyledPage>
    );
  }

  return (
    <StyledPage>
      <StyledTitle>Задачи</StyledTitle>

      {Object.entries(groups).map(([name, items]) =>
        items.length === 0 ? null : (
          <StyledGroup key={name}>
            <StyledGroupName isLate={name === 'Просрочено'}>
              {name} · {items.length}
            </StyledGroupName>
            {items.map(row)}
          </StyledGroup>
        ),
      )}

      {draft === null ? (
        <StyledAdd onClick={() => setDraft('')}>+ Новая задача</StyledAdd>
      ) : (
        <StyledRow isDone={false}>
          <StyledCheck isDone={false} />
          <StyledBody>
            <StyledTitleInput
              isDone={false}
              autoFocus
              placeholder="Что сделать — Enter, чтобы добавить"
              value={draft}
              onChange={(event) => setDraft(event.target.value)}
              onKeyDown={(event) => {
                if (event.key === 'Enter') addTask(draft);
                if (event.key === 'Escape') setDraft(null);
              }}
              onBlur={() => draft.trim() === '' && setDraft(null)}
            />
          </StyledBody>
        </StyledRow>
      )}
    </StyledPage>
  );
};
