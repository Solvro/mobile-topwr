import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../hooks/use_effect_on_init.dart";
import "../../services/translations_service/data/preferred_lang_repository.dart";
import "../settings/widgets/language_settings_dialog.dart";
import "show_changelog.dart";

class UpdateChangelogWrapper extends HookConsumerWidget {
  const UpdateChangelogWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(() {
      Future.microtask(() async {
        if (context.mounted) {
          final preferredLanguage = await ref.read(preferredLanguageRepositoryProvider.future);
          if (preferredLanguage == null && context.mounted) {
            await LanguageDialog.show(context, isFirstTimeMode: true);
          }
        }
        if (context.mounted) {
          await showChangelog(context, ref);
        }
      });
      return null;
    });
    return child;
  }
}
