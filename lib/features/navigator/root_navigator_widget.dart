import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../bottom_nav_bar/bottom_nav_bar.dart";
import "../bottom_nav_bar/bottom_nav_bar_controller.dart";
import "navigator/nested_navigator.dart";
import "utils/android_pop_bug_workaround.dart";

class RootNavigatorWidget extends ConsumerWidget {
  const RootNavigatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.watch(navigatorProvider);
    final bottomNavController =
        ref.watch(bottomNavBarControllerProvider.notifier);
    return Scaffold(
      body: PopScope(
        canPop: !navigator.androidSpecialPopTreatment,
        child: NavigatorPopHandler(
          onPop: navigator.handleNestedPop,
          child: Navigator(
            key: navigator.navigatorKey,
            onGenerateRoute: navigator.onGenerateRoute,
            observers: [bottomNavController.selectedTabObserver],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: const BottomNavBar(),
      ),
    );
  }
}
