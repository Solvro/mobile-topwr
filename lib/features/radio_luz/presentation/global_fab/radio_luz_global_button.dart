import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../../gen/assets.gen.dart";
import "../../../../theme/app_theme.dart";
import "../../../../widgets/position_detector.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "radio_luz_global_button_position.dart";

class RadioLuzGlobalButton extends ConsumerWidget {
  const RadioLuzGlobalButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PositionDetector(
      onChange: (size, _, right, bottom, _) {
        ref
            .read(radioLuzGlobalCurrentButtonPosProvider.notifier)
            .setPosition(topEdge: bottom + size.height, rightEdge: right);
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.3, end: 1),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
        builder: (_, opacity, child) {
          return Opacity(opacity: opacity, child: child);
        },
        child: FloatingActionButton(
          heroTag: "radioLuzFab",
          elevation: 3,
          backgroundColor: context.colorTheme.orangePomegranadeLighter,
          onPressed: () async {
            await ref.navigateToRadioLuz();
          },
          child: SvgPicture.asset(
            Assets.svg.radioLuz.fabIcon,
            colorFilter: ColorFilter.mode(context.colorTheme.whiteSoap, BlendMode.srcIn),
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
