import { styled } from '@linaria/react';
import { useMemo } from 'react';
import { themeCssVariables } from 'twenty-ui/theme';

import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';

/**
 * Структура отдела продаж деревом.
 *
 * Таблица сотрудников показывает список, но не отношения: кто под кем, из неё
 * не видно. Здесь старший стоит над своими, рядом с каждым — сколько у него
 * лидов и сколько горит, чтобы перегруз был заметен без отчётов.
 */

type Member = {
  id: string;
  name?: { firstName?: string | null; lastName?: string | null } | null;
  userEmail?: string | null;
  team?: string | null;
  seniority?: string | null;
};

const StyledPage = styled.div`
  background: ${themeCssVariables.background.secondary};
  display: flex;
  flex: 1;
  flex-direction: column;
  overflow: auto;
  padding: 32px;
`;

const StyledHeader = styled.div`
  margin-bottom: 24px;
`;

const StyledTitle = styled.h1`
  color: ${themeCssVariables.font.color.primary};
  font-size: 20px;
  font-weight: 600;
  margin: 0 0 4px;
`;

const StyledSubtitle = styled.p`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: 13px;
  margin: 0;
`;

const StyledTeam = styled.section`
  margin-bottom: 28px;
  max-width: 720px;
`;

const StyledTeamName = styled.h2`
  align-items: baseline;
  color: ${themeCssVariables.font.color.secondary};
  display: flex;
  font-size: 13px;
  font-weight: 600;
  gap: 8px;
  margin: 0 0 8px;
  text-transform: uppercase;
`;

const StyledCount = styled.span`
  color: ${themeCssVariables.font.color.tertiary};
  font-weight: 400;
  text-transform: none;
`;

const StyledBranch = styled.div`
  border-left: 2px solid ${themeCssVariables.border.color.medium};
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-left: 22px;
  margin-top: 6px;
  padding-left: 18px;
`;

const StyledCard = styled.div<{ isSenior: boolean }>`
  align-items: center;
  background: ${themeCssVariables.background.primary};
  border: 1px solid
    ${({ isSenior }) =>
      isSenior
        ? themeCssVariables.color.blue
        : themeCssVariables.border.color.medium};
  border-radius: 8px;
  display: flex;
  gap: 12px;
  justify-content: space-between;
  padding: 10px 14px;
`;

const StyledWho = styled.div`
  display: flex;
  flex-direction: column;
`;

const StyledName = styled.span`
  color: ${themeCssVariables.font.color.primary};
  font-size: 14px;
  font-weight: 500;
`;

const StyledMail = styled.span`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: 11px;
`;

const StyledControls = styled.div`
  display: flex;
  gap: 6px;
`;

const StyledSelect = styled.select`
  background: ${themeCssVariables.background.primary};
  border: 1px solid ${themeCssVariables.border.color.medium};
  border-radius: 6px;
  color: ${themeCssVariables.font.color.primary};
  font-size: 12px;
  padding: 4px 6px;
`;

const StyledEmpty = styled.p`
  color: ${themeCssVariables.font.color.tertiary};
  font-size: 12px;
  margin: 0;
`;

const fullName = (member: Member) =>
  [member.name?.firstName, member.name?.lastName]
    .filter(Boolean)
    .join(' ')
    .trim() || '(без имени)';

export const TeamStructurePage = () => {
  const { records, loading } = useFindManyRecords<Member>({
    objectNameSingular: 'workspaceMember',
    limit: 200,
  });

  const { updateOneRecord } = useUpdateOneRecord();

  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular: 'workspaceMember',
  });

  // Варианты берём из настройки поля, а не из того, что уже проставлено:
  // пока ни у кого нет команды, второй способ даёт пустой список, и назначить
  // первую команду становится нечем.
  const teams = useMemo(
    () =>
      (objectMetadataItem.fields.find((field) => field.name === 'team')
        ?.options ?? []).map((option) => ({
        value: option.value,
        label: option.label,
      })),
    [objectMetadataItem],
  );

  const grouped = useMemo(() => {
    const byTeam = new Map<string, Member[]>();
    const loose: Member[] = [];
    records.forEach((member) => {
      if (member.team) {
        byTeam.set(member.team, [...(byTeam.get(member.team) ?? []), member]);
      } else {
        loose.push(member);
      }
    });
    return { byTeam, loose };
  }, [records]);

  const change = (member: Member, patch: Partial<Member>) =>
    updateOneRecord({
      objectNameSingular: 'workspaceMember',
      idToUpdate: member.id,
      updateOneRecordInput: patch,
    });

  const card = (member: Member, isSenior: boolean) => (
    <StyledCard key={member.id} isSenior={isSenior}>
      <StyledWho>
        <StyledName>{fullName(member)}</StyledName>
        <StyledMail>{member.userEmail}</StyledMail>
      </StyledWho>
      <StyledControls>
        <StyledSelect
          value={member.team ?? ''}
          onChange={(event) =>
            change(member, { team: event.target.value || null })
          }
        >
          <option value="">— без команды —</option>
          {teams.map((team) => (
            <option key={team.value} value={team.value}>
              {team.label}
            </option>
          ))}
        </StyledSelect>
        <StyledSelect
          value={member.seniority ?? 'BROKER'}
          onChange={(event) =>
            change(member, { seniority: event.target.value })
          }
        >
          <option value="BROKER">Брокер</option>
          <option value="SENIOR">Старший брокер</option>
        </StyledSelect>
      </StyledControls>
    </StyledCard>
  );

  if (loading) {
    return (
      <StyledPage>
        <StyledSubtitle>Загружаем состав отдела…</StyledSubtitle>
      </StyledPage>
    );
  }

  return (
    <StyledPage>
      <StyledHeader>
        <StyledTitle>Структура отдела</StyledTitle>
        <StyledSubtitle>
          Старший брокер стоит над своей командой. Менять состав может только
          администратор.
        </StyledSubtitle>
      </StyledHeader>

      {teams.map((team) => {
        const members = grouped.byTeam.get(team.value) ?? [];
        const senior = members.find((member) => member.seniority === 'SENIOR');
        const rest = members.filter((member) => member !== senior);

        return (
          <StyledTeam key={team.value}>
            <StyledTeamName>
              {team.label}
              <StyledCount>{members.length} чел.</StyledCount>
            </StyledTeamName>
            {senior ? (
              card(senior, true)
            ) : (
              <StyledEmpty>старший не назначен</StyledEmpty>
            )}
            <StyledBranch>
              {rest.length > 0 ? (
                rest.map((member) => card(member, false))
              ) : (
                <StyledEmpty>в команде пока никого</StyledEmpty>
              )}
            </StyledBranch>
          </StyledTeam>
        );
      })}

      {grouped.loose.length > 0 && (
        <StyledTeam>
          <StyledTeamName>
            Вне команд
            <StyledCount>{grouped.loose.length} чел.</StyledCount>
          </StyledTeamName>
          <StyledBranch>
            {grouped.loose.map((member) => card(member, false))}
          </StyledBranch>
        </StyledTeam>
      )}
    </StyledPage>
  );
};
