import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../navigator/utils/navigation_commands.dart";

class RadioLuzGlobalButton extends ConsumerWidget {
  const RadioLuzGlobalButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      elevation: 1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      onPressed: () async {
        await ref.navigateToRadioLuz();
      },
      color: context.colorTheme.orangePomegranade,
      textColor: context.colorTheme.whiteSoap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: SvgPicture.asset(
        Assets.svg.radioLuz.fabIcon,
        colorFilter: ColorFilter.mode(context.colorTheme.whiteSoap, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
    );
  }
}
