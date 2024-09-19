import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../bottom_nav_bar/bottom_nav_bar.dart";
import "navigation_controller.dart";
import "utils/android_pop_bug_workaround.dart";

@RoutePage()
class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialPop = ref.androidSpecialPopTreatment;
    return PopScope(
      canPop: !specialPop, // android pop bug workaround
      child: NavigatorPopHandler(
        onPop: specialPop ? ref.handleAndroidSpecialPop : null,
        child: Scaffold(
          body: AutoRouter(
            // this widget act as nested [Navigator] for the app
            key: ref.watch(navigationControllerProvider.notifier).navigatorKey,
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}
