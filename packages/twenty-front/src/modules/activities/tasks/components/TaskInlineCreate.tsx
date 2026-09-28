import { styled } from '@linaria/react';
import { t } from '@lingui/core/macro';
import { useState } from 'react';
import { themeCssVariables } from 'twenty-ui/theme';

import { useCreateTaskInline } from '@/activities/tasks/hooks/useCreateTaskInline';
import { type ActivityTargetableObject } from '@/activities/types/ActivityTargetableEntity';

/**
 * Строка «новая задача» над списком.
 *
 * Наверху, потому что список растёт вниз без ограничения по высоте: внизу
 * строка уезжала бы за экран тем дальше, чем больше задач уже заведено.
 *
 * Enter создаёт задачу и оставляет поле пустым и в фокусе: подряд записать
 * три дела нужно чаще, чем одно, и каждое не должно стоить отдельного окна.
 */

const StyledRow = styled.div`
  align-items: center;
  border-bottom: 1px solid ${themeCssVariables.border.color.light};
  display: flex;
  gap: ${themeCssVariables.spacing[2]};
  padding: ${themeCssVariables.spacing[2]} 0;
  width: 100%;
`;

const StyledBox = styled.span`
  border: 1.5px solid ${themeCssVariables.border.color.strong};
  border-radius: 50%;
  flex-shrink: 0;
  height: 16px;
  width: 16px;
`;

const StyledInput = styled.input`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.primary};
  flex: 1;
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.md};
  min-width: 0;
  outline: none;
  padding: 0;

  &::placeholder {
    color: ${themeCssVariables.font.color.light};
  }
`;

type TaskInlineCreateProps = {
  targetableObject: ActivityTargetableObject;
};

export const TaskInlineCreate = ({
  targetableObject,
}: TaskInlineCreateProps) => {
  const [title, setTitle] = useState('');
  const [isSaving, setIsSaving] = useState(false);
  const { createTask } = useCreateTaskInline(targetableObject);

  const submit = async () => {
    if (title.trim() === '' || isSaving) {
      return;
    }

    setIsSaving(true);

    try {
      await createTask(title);
      setTitle('');
    } finally {
      setIsSaving(false);
    }
  };

  return (
    <StyledRow>
      <StyledBox />
      <StyledInput
        value={title}
        placeholder={t`New task — press Enter`}
        onChange={(event) => setTitle(event.target.value)}
        onKeyDown={(event) => {
          if (event.key === 'Enter') {
            event.preventDefault();
            submit();
          }

          if (event.key === 'Escape') {
            setTitle('');
            event.currentTarget.blur();
          }
        }}
      />
    </StyledRow>
  );
};
