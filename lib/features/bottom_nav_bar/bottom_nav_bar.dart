import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../theme/app_theme.dart";
import "../navigator/navigation_controller.dart";

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(navigationControllerProvider).activeTab;
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 255.0 * .08),
              blurRadius: 20,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: activeTab.index,
          onTap: (index) async => ref
              .read(navigationControllerProvider.notifier)
              .onTabBarChange(NavBarEnum.values[index]),
          backgroundColor: context.colorTheme.greyLight,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: _NavigationBarItemsList(activeTab, context),
        ),
      ),
    );
  }
}

class _NavigationBarItemsList extends DelegatingList<BottomNavigationBarItem> {
  _NavigationBarItemsList(NavBarEnum selectedTab, BuildContext context)
      : super(
          NavBarEnum.values
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon,
                    color: e == selectedTab
                        ? context.colorTheme.orangePomegranade
                        : context.colorTheme.blackMirage
                            .withValues(alpha: 255.0 * .16),
                    size: e.size,
                  ),
                  label: e.label,
                ),
              )
              .toList(),
        );
}
