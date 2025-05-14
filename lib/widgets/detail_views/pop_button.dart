import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../features/navigator/navigation_stack.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";

class DetailViewPopButton extends ConsumerWidget {
  const DetailViewPopButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ModalRoute.of(context)?.settings;
    final title = route != null ? ref.watch(previousRouteThanProvider(route))?.getFormattedRouteName(context) : null;

    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
      child: Text(
        title == null ? "<" : "< $title",
        style: context.textTheme.boldBodyOrange,
        semanticsLabel: "${context.localize.get_back_screen_reader_label} $title",
      ),
    );
  }
}
