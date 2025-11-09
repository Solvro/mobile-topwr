import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../navigator/utils/navigation_commands.dart";
import "radio_luz_logo.dart";

class RadioLuzGlobalButton extends ConsumerWidget {
  const RadioLuzGlobalButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      elevation: 1,
      padding: const EdgeInsets.all(8),
      onPressed: () async {
        await ref.navigateToRadioLuz();
      },
      color: context.colorTheme.orangePomegranade,
      textColor: context.colorTheme.whiteSoap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: RadioLuzLogo(logoColor: context.colorTheme.whiteSoap, logoSize: 24),
    );
  }
}
