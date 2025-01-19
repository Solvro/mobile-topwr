import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../app_changelog/update_changelog_wrapper.dart";
import "../bottom_nav_bar/bottom_nav_bar.dart";
import "navigation_controller.dart";
import "utils/android_pop_bug_workaround.dart";

@RoutePage()
class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialPop = ref.androidSpecialPopTreatment;
    final mediaQuery = MediaQuery.of(context);
    final isOnRightSide = mediaQuery.padding.right > mediaQuery.padding.left;
    final isOnLeftSide = mediaQuery.padding.left > mediaQuery.padding.right;

    EdgeInsets getPadding() {
      if (isOnLeftSide) {
        return EdgeInsets.only(right: MediaQuery.paddingOf(context).left);
      } else if (isOnRightSide) {
        return EdgeInsets.only(left: MediaQuery.paddingOf(context).right);
      } else {
        return EdgeInsets.zero;
      }
    }

    return PopScope(
      canPop: !specialPop, // android pop bug workaround
      child: NavigatorPopHandler(
        onPopWithResult:
            specialPop ? (result) async => ref.handleAndroidSpecialPop() : null,
        child: UpdateChangelogWrapper(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: getPadding(),
                child: AutoRouter(
                  // this widget acts as nested [Navigator] for the app
                  key: ref.watch(navigatorKeyProvider),
                ),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        ),
      ),
    );
  }
}
