import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../bottom_nav_bar/bottom_nav_height.dart";
import "../../radio_luz/presentation/radio_luz_global_button.dart";
import "../../radio_luz/service/radio_player_controller.dart";
import "../app_router.dart";
import "../navigation_stack.dart";

@RoutePage()
class ApplicationView extends ConsumerWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(currentRouteProvider)?.settings.name;
    final radioState = ref.watch(radioControllerProvider);
    final showRadioLuzButton = radioState.isPlaying && currentRoute != RadioLuzRoute.name;
    final isBottomNav = currentRoute == RootRoute.name;

    final bottomNavHeight = ref.watch(bottomNavBarHeightProvider);
    final double bottomPosition = isBottomNav ? (bottomNavHeight > 0 ? bottomNavHeight + 16 : 80) : 36;

    return Stack(
      children: [
        const AutoRouter(),
        if (showRadioLuzButton)
          AnimatedPositioned(
            right: 24,
            bottom: bottomPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: const RadioLuzGlobalButton(),
          ),
      ],
    );
  }
}
