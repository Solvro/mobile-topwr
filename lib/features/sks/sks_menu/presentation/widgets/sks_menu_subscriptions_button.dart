import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../navigator/utils/navigation_commands.dart";

class SksMenuSubscriptionsButton extends ConsumerWidget {
  const SksMenuSubscriptionsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: ref.navigateToSksMenuSubscriptions,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: SksMenuConfig.paddingLarge,
          vertical: SksMenuConfig.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
          border: Border.all(color: context.colorTheme.orangePomegranade.withAlpha(50)),
        ),
        child: const Text("See subscribed dishes"),
      ),
    );
  }
}
