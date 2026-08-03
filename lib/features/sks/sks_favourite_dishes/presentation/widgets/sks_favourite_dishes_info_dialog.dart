import "package:flutter/material.dart";

import "../../../../../services/haptics/app_haptics.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";

class SksFavouriteDishesInfoDialog extends StatelessWidget {
  const SksFavouriteDishesInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 36.0;
    const bottomPadding = 24.0;
    return AlertDialog(
      semanticLabel:
          context.localize.dialog_semantics_label +
          context.localize.sks_favourite_dishes_how_it_works_question +
          context.localize.sks_favourite_dishes_how_it_works,
      titlePadding: const EdgeInsets.only(left: horizontalPadding, top: 32, right: horizontalPadding),
      contentPadding: const EdgeInsets.only(
        left: horizontalPadding,
        top: 16,
        right: horizontalPadding,
        bottom: bottomPadding / 1.5,
      ),
      actionsPadding: const EdgeInsets.only(
        bottom: bottomPadding,
        left: horizontalPadding / 1.5,
        right: horizontalPadding / 1.5,
      ),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(context.localize.sks_favourite_dishes_how_it_works_question, style: context.textTheme.headlineMedium),
      actions: [
        TextButton(
          onPressed: AppHaptics.wrapperLight(() => Navigator.of(context).pop()),
          style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
          child: Text(
            context.localize.ok,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
          ),
        ),
      ],
      content: SizedBox(
        width: double.infinity,
        child: RichText(
          textScaler: context.textScaler.clamp(maxScaleFactor: 1.2),
          text: TextSpan(
            text: context.localize.sks_favourite_dishes_how_it_works,
            style: context.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
