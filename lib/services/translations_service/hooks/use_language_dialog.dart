import "dart:async";

import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../features/settings/widgets/language_settings_dialog.dart" show LanguageDialog;
import "../../../hooks/use_effect_on_init.dart";
import "../data/preferred_lang_repository.dart";

void useLanguageDialogIfNotSet(BuildContext context, WidgetRef ref) {
  useEffectOnInit(() {
    unawaited(
      Future.microtask(() async {
        final preferredLanguage = await ref.read(preferredLanguageRepositoryProvider.future);
        if (preferredLanguage == null && context.mounted) {
          await LanguageDialog.show(context, isFirstTimeMode: true);
        }
      }),
    );
    return null;
  });
}
