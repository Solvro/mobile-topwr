import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import 'android_pop_bug_workaround.dart';
import 'bottom_nav_bar_controller.dart';
import 'nav_bar_config.dart';
import 'nested_navigator.dart';

class RootViewWithBottomNavBar extends ConsumerWidget {
  const RootViewWithBottomNavBar({super.key});

  List<BottomNavigationBarItem> getNavigationBarItems(
    BuildContext context,
    NavBarEnum selectedTab,
  ) {
    return NavBarEnum.values
        .map((e) => BottomNavigationBarItem(
              icon: Icon(
                e.icon,
                color: e == selectedTab
                    ? context.colorTheme.orangePomegranade
                    : context.colorTheme.blackMirage.withOpacity(.16),
                size: e.size,
              ),
              label: e.label,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bottomNavBarControllerProvider);
    final navigator = ref.watch(navigatorProvider);
    return Scaffold(
        body: PopScope(
          canPop: !navigator.androidSpecialPopTreatment,
          child: NavigatorPopHandler(
            onPop: navigator.handleNestedPop,
            child: Navigator(
              key: navigator.navigatorKey,
              onGenerateRoute: navigator.onGenerateRoute,
            ),
          ),
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
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
                  onTap: ref
                      .watch(bottomNavBarControllerProvider.notifier)
                      .onIndexChanged,
                  backgroundColor: context.colorTheme.greyLight,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: getNavigationBarItems(context, selectedTab),
                ))));
  }
}
