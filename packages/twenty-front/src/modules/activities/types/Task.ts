import { type Activity } from '@/activities/types/Activity';
import { type WorkspaceMember } from '@/workspace-member/types/WorkspaceMember';

type ActivityStatus = 'TODO' | 'IN_PROGRESS' | 'DONE' | 'CANCELLED';

export type Task = Activity & {
  assignee: Pick<
    WorkspaceMember,
    'id' | 'name' | 'avatarUrl' | 'colorScheme'
  > | null;
  assigneeId: string | null;
  status: ActivityStatus | null;
  // Две даты, как в Craft: scheduledAt — когда берутся за дело,
  // dueAt — крайний срок. Просрочкой считается только второй.
  dueAt: string | null;
  scheduledAt: string | null;
  __typename: 'Task';
};
