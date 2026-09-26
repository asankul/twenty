import { type NavigationMenuItem } from '~/generated-metadata/graphql';

export const getLinkNavigationMenuItemComputedLink = (
  item: Pick<NavigationMenuItem, 'link'>,
): string => {
  const linkUrl = (item.link ?? '').trim();
  if (linkUrl.startsWith('http://') || linkUrl.startsWith('https://')) {
    return linkUrl;
  }
  // Адрес, начинающийся со слэша, — страница самого приложения. Дописывать
  // ему протокол значит выбрасывать человека в новую вкладку на битый адрес.
  if (linkUrl.startsWith('/')) {
    return linkUrl;
  }
  return linkUrl ? `https://${linkUrl}` : '';
};
