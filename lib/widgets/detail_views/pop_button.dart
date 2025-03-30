import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../features/navigator/navigation_controller.dart";
import "../../services/translations_service/widgets/text_with_translation.dart";
import "../../theme/app_theme.dart";

class DetailViewPopButton extends ConsumerWidget {
  const DetailViewPopButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final title =
        currentRoute == null
            ? null
            : ref.watch(previousRouteOnStackProvider(currentRoute))?.getFormatedRouteName(context);

    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
      child: TextWithTranslation(title == null ? "<" : "< $title", style: context.textTheme.boldBodyOrange),
    );
  }
}
