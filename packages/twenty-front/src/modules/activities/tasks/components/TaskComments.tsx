import { styled } from '@linaria/react';
import { t } from '@lingui/core/macro';
import { useMemo, useState } from 'react';
import { themeCssVariables } from 'twenty-ui/theme';

import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { useCreateOneRecord } from '@/object-record/hooks/useCreateOneRecord';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { useAtomStateValue } from '@/ui/utilities/state/jotai/hooks/useAtomStateValue';

/**
 * Лента комментариев под задачей.
 *
 * У задач в Twenty комментариев нет: заметки цепляются к лидам и клиентам,
 * а обсуждение конкретного дела вести негде — оно расползается по переписке
 * и теряется. Здесь оно лежит рядом с задачей и видно всем.
 */

type Comment = {
  id: string;
  text?: string | null;
  createdAt?: string | null;
  authorId?: string | null;
};

type Member = {
  id: string;
  name?: { firstName?: string | null; lastName?: string | null } | null;
};

const StyledBlock = styled.div`
  border-left: 2px solid ${themeCssVariables.border.color.light};
  display: flex;
  flex-direction: column;
  gap: ${themeCssVariables.spacing[2]};
  margin: ${themeCssVariables.spacing[1]} 0 ${themeCssVariables.spacing[2]}
    ${themeCssVariables.spacing[6]};
  padding-left: ${themeCssVariables.spacing[3]};
`;

const StyledComment = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1px;
`;

const StyledMeta = styled.span`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: ${themeCssVariables.font.size.xxs};
`;

const StyledText = styled.span`
  color: ${themeCssVariables.font.color.primary};
  font-size: ${themeCssVariables.font.size.sm};
  white-space: pre-wrap;
`;

const StyledInput = styled.input`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.primary};
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.sm};
  outline: none;
  padding: 2px 0;
  width: 100%;

  &::placeholder {
    color: ${themeCssVariables.font.color.light};
  }
`;

const fullName = (member?: Member) =>
  [member?.name?.firstName, member?.name?.lastName]
    .filter(Boolean)
    .join(' ')
    .trim();

const when = (value?: string | null) =>
  value === null || value === undefined
    ? ''
    : new Date(value).toLocaleString('ru-RU', {
        day: 'numeric',
        month: 'short',
        hour: '2-digit',
        minute: '2-digit',
      });

export const TaskComments = ({ taskId }: { taskId: string }) => {
  const [draft, setDraft] = useState('');
  const currentWorkspaceMember = useAtomStateValue(currentWorkspaceMemberState);

  // Имя автора берём из справочника, а не из связи комментария: связанную
  // запись запрос не возвращает, и подпись выходила пустой.
  const { records: members } = useFindManyRecords<Member>({
    objectNameSingular: 'workspaceMember',
    limit: 200,
  });

  const nameById = useMemo(
    () => new Map(members.map((member) => [member.id, fullName(member)])),
    [members],
  );

  const { records: comments } = useFindManyRecords<Comment>({
    objectNameSingular: 'taskComment',
    filter: { taskId: { eq: taskId } },
    orderBy: [{ createdAt: 'AscNullsLast' }],
    limit: 100,
  });

  const { createOneRecord } = useCreateOneRecord({
    objectNameSingular: 'taskComment',
  });

  const submit = async () => {
    const text = draft.trim();

    if (text === '') {
      return;
    }

    await createOneRecord({
      text,
      taskId,
      authorId: currentWorkspaceMember?.id,
    });

    setDraft('');
  };

  return (
    <StyledBlock onClick={(event) => event.stopPropagation()}>
      {comments.map((comment) => (
        <StyledComment key={comment.id}>
          <StyledMeta>
            {(comment.authorId ? nameById.get(comment.authorId) : '') ||
              t`Someone`}{' '}
            · {when(comment.createdAt)}
          </StyledMeta>
          <StyledText>{comment.text}</StyledText>
        </StyledComment>
      ))}
      <StyledInput
        value={draft}
        placeholder={t`Type your comment`}
        onChange={(event) => setDraft(event.target.value)}
        onKeyDown={(event) => {
          if (event.key === 'Enter') {
            event.preventDefault();
            submit();
          }
        }}
      />
    </StyledBlock>
  );
};
