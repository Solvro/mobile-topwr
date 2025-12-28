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

      child: Semantics(
        label: "${context.localize.get_back_screen_reader_label} $title",
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(Icons.chevron_left, size: 18, color: context.colorScheme.primary),
            ),
            if (title != null)
              Flexible(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
