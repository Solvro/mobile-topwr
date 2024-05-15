import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nested_navigator.dart';
import '../../theme/app_theme.dart';
import 'bottom_nav_bar_controller.dart';
import 'nav_bar_config.dart';

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
    const platform = MethodChannel('topwr.app.android.channel');
    final selectedTab = ref.watch(bottomNavBarControllerProvider);
    final navigator = ref.watch(navigatorProvider);
    return
         WillPopScope(
      onWillPop: () async {
          if(Platform.isAndroid && (navigator.navigatorKey.currentState!.canPop() == false)) {
            platform.invokeMethod<int>('putAppInBackground');
            return false;
          }
        else {
          return true;
        }
      },
        child: Scaffold(
            body: NavigatorPopHandler(
              onPop: navigator.handleNestedPop,
              child: Navigator(
                key: navigator.navigatorKey,
                onGenerateRoute: navigator.onGenerateRoute,
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
                    )))));
  }
}
