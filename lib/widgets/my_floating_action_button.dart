import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../config/ui_config.dart";
import "../features/navigator/providers/is_bottom_sheet_open.dart";
import "../features/radio_luz/presentation/global_fab/radio_luz_global_button_position.dart";
import "../features/radio_luz/service/radio_player_controller.dart";
import "../theme/app_theme.dart";

class MyFloatingActionButton extends ConsumerWidget {
  const MyFloatingActionButton({
    super.key,
    required this.icon,
    required this.heroTag,
    required this.onPressed,
    required this.bottomInset,
    this.iconColor,
    this.backgroundColor,
    this.tooltip,
  });

  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String heroTag;
  final VoidCallback onPressed;
  final double bottomInset;
  final String? tooltip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRadioPlaying = ref.watch(radioControllerProvider).isPlaying;
    final radioFabPos = ref.watch(radioLuzGlobalCurrentButtonPosProvider);

    final fabBottom = isRadioPlaying ? radioFabPos.topEdge - bottomInset + FabConfig.spacing : FabConfig.defaultBottom;
    final fabRight = isRadioPlaying ? radioFabPos.rightEdge : FabConfig.right;

    final targetOpacity = ref.watch(isBottomSheetOpenProvider) ? 0.3 : 1.0;

    return Positioned(
      bottom: fabBottom,
      right: fabRight,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.3, end: targetOpacity),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
        builder: (_, opacity, child) {
          return Opacity(opacity: opacity, child: child);
        },
        child: FloatingActionButton(
          heroTag: heroTag,
          tooltip: tooltip,
          elevation: 3,
          backgroundColor: backgroundColor ?? context.colorTheme.orangePomegranadeLighter,
          onPressed: onPressed,
          child: Icon(icon, color: iconColor ?? context.colorTheme.whiteSoap),
        ),
      ),
    );
  }
}
