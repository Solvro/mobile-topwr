import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../services/pop_scope/centralized_pop_scope.dart";
import "../../widgets/horizontal_symmetric_safe_area.dart";
import "../app_changelog/update_changelog_wrapper.dart";
import "../bottom_nav_bar/bottom_nav_bar.dart";
import "nested_nav_pop_scope.dart";
import "utils/route_params_controller.dart";

@RoutePage()
class RootView extends HookConsumerWidget {
  const RootView({
    super.key,
    this.initialTabToGetBackTo = NavBarEnum.home,
    this.isFirstRootBottomView = true,
    // @QueryParam("q") this.query,
  });

  // final String? query;

  final NavBarEnum initialTabToGetBackTo;
  final bool isFirstRootBottomView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(context.router.current.name);
    final query = Uri.parse(context.router.currentUrl).queryParameters["q"];
    print("ROOT VIEW: $query");
    if (query != null && context.router.current.name == "RootRoute") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // final current = context.router.current;
        // final newUrl = Uri(
        //   path: current.path,
        //   queryParameters: {},
        // ).toString();

        // await context.router.replacePath(newUrl);
        // print("replacing");
        ref.read(routeParamsControllerProvider.notifier).onParamsChanged(query);
      });
    }

    final timesPushedToTabBar = useState(0);
    return ShowEntryDialogWrapper(
      child: AutoTabsRouter(
        routes: NavBarConfig.tabViews.values.toList(),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return CentralizedPopScope(
            child: NestedNavPopScope(
              initialTabToGetBackTo: initialTabToGetBackTo,
              isFirstRootBottomView: isFirstRootBottomView,
              timesPushedToTabBar: timesPushedToTabBar.value,
              child: HorizontalSymmetricSafeAreaScaffold(
                bottomNavigationBar: BottomNavBar(
                  activeIndex: tabsRouter.activeIndex,
                  onTap: (index) {
                    timesPushedToTabBar.value++;
                    tabsRouter.setActiveIndex(index);
                  },
                ),
                body: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
