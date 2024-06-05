import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../navigator/navigator/nested_navigator.dart';
import '../navigator/navigator/tab_bar_navigator.dart';
import 'bottom_nav_bar_controller.dart';
import '../../config/nav_bar_config.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bottomNavBarControllerProvider);
    final navigator = ref.watch(navigatorProvider);

    return Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 20,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedTab.index,
          onTap: (index) => navigator.changeTabBar(NavBarEnum.values[index]),
          backgroundColor: context.colorTheme.greyLight,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: _NavigationBarItemsList(selectedTab, context),
        ));
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
                        : context.colorTheme.blackMirage.withOpacity(.16),
                    size: e.size,
                  ),
                  label: e.label,
                ),
              )
              .toList(),
        );
}
