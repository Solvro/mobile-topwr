import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../bottom_nav_bar/bottom_nav_height.dart";
import "../../radio_luz/presentation/global_fab/radio_luz_global_button.dart";
import "../../radio_luz/presentation/global_fab/radio_luz_global_button_position.dart";
import "../../radio_luz/service/radio_player_controller.dart";
import "../app_router.dart";
import "../is_overlay_open.dart";
import "../navigation_stack.dart";

@RoutePage()
class ApplicationView extends ConsumerWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(currentRouteProvider)?.settings.name;
    final showRadioLuzButton = ref.watch(radioControllerProvider).isPlaying && currentRoute != RadioLuzRoute.name;

    final isOverlayOpen = ref.watch(isOverlayOpenProvider);
    double fabBottomPosition = ref.watch(radioLuzGlobalLastButtonBottomProvider);
    if (!isOverlayOpen) {
      final isBottomNav = ref.watch(isBottomNavProvider);
      final bottomNavHeight = ref.watch(bottomNavBarHeightProvider);
      fabBottomPosition = isBottomNav ? (bottomNavHeight > 0 ? bottomNavHeight + 16 : 80) : 44;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(radioLuzGlobalLastButtonBottomProvider.notifier).setBottom(fabBottomPosition);
      });
    }

    return Stack(
      children: [
        const AutoRouter(),
        if (showRadioLuzButton)
          AnimatedPositioned(
            right: FabConfig.right,
            bottom: fabBottomPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: const RadioLuzGlobalButton(),
          ),
      ],
    );
  }
}
