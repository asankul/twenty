import { styled } from '@linaria/react';
import { useState } from 'react';
import { IconSearch, IconX } from 'twenty-ui/icon';
import { themeCssVariables } from 'twenty-ui/theme';

import { anyFieldFilterValueComponentState } from '@/object-record/record-filter/states/anyFieldFilterValueComponentState';
import { useAtomComponentState } from '@/ui/utilities/state/jotai/hooks/useAtomComponentState';

/**
 * Поиск внутри раздела.
 *
 * Общий поиск по Cmd+K ищет по всему сразу и уводит на отдельный экран.
 * Здесь другое: написал — и колонки воронки сузились до найденного,
 * не покидая доски. Под капотом тот же фильтр «по любому полю», который
 * у Twenty спрятан в выпадашке на три клика вглубь.
 */
const StyledWrapper = styled.div`
  align-items: center;
  background: ${themeCssVariables.background.transparent.lighter};
  border: 1px solid ${themeCssVariables.border.color.medium};
  border-radius: ${themeCssVariables.border.radius.sm};
  color: ${themeCssVariables.font.color.tertiary};
  display: flex;
  gap: ${themeCssVariables.spacing[1]};
  height: 24px;
  padding: 0 ${themeCssVariables.spacing[2]};

  &:focus-within {
    border-color: ${themeCssVariables.color.blue};
  }
`;

const StyledInput = styled.input`
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.primary};
  font-family: inherit;
  font-size: ${themeCssVariables.font.size.sm};
  outline: none;
  width: 140px;

  &::placeholder {
    color: ${themeCssVariables.font.color.light};
  }
`;

const StyledClear = styled.button`
  align-items: center;
  background: transparent;
  border: 0;
  color: ${themeCssVariables.font.color.tertiary};
  cursor: pointer;
  display: flex;
  padding: 0;
`;

export const ViewBarSearchInput = () => {
  const [anyFieldFilterValue, setAnyFieldFilterValue] = useAtomComponentState(
    anyFieldFilterValueComponentState,
  );
  const [draft, setDraft] = useState(anyFieldFilterValue);

  const apply = (value: string) => {
    setDraft(value);
    setAnyFieldFilterValue(value);
  };

  return (
    <StyledWrapper>
      <IconSearch size={14} />
      <StyledInput
        type="text"
        value={draft}
        placeholder="Искать здесь"
        onChange={(event) => apply(event.target.value)}
        onKeyDown={(event) => {
          if (event.key === 'Escape') apply('');
        }}
      />
      {draft !== '' && (
        <StyledClear type="button" aria-label="Очистить" onClick={() => apply('')}>
          <IconX size={12} />
        </StyledClear>
      )}
    </StyledWrapper>
  );
};
