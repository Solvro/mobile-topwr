import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../../utils/context_extensions.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({required this.isFirstTimeMode, super.key});

  final bool isFirstTimeMode;

  static Future<String?> show(BuildContext context, {bool isFirstTimeMode = false}) {
    return showDialog<String>(
      context: context,
      builder: (context) => LanguageDialog(isFirstTimeMode: isFirstTimeMode),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = context.localize.localeName;
    final languages = [
      (context.localize.polish_id, context.localize.polish_title),
      (context.localize.english_id, context.localize.english_title),
    ];
    return Semantics(
      container: true,
      label: context.localize.dialog_semantics_label,
      child: Focus(
        autofocus: true,
        child: RedDialog(
          centerTitle: isFirstTimeMode,
          title: isFirstTimeMode ? context.localize.select_language : context.localize.language,
          subtitle: null,
          showApplyButton: isFirstTimeMode,
          applyButtonText: context.localize.select,
          onApplyButtonPressed: () async {
            await ref
                .read(preferredLanguageRepositoryProvider.notifier)
                .setPreferredLanguage(SolvroLocale.values.byName(selectedLanguage));
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final (code, name) = languages[index];
              final selected = selectedLanguage == code;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
                    color: context.colorTheme.greyLight,
                  ),
                  child: ListTile(
                    selected: selected,
                    title: Text(semanticsLabel: name.substring(1), name),
                    trailing: selected ? Icon(Icons.check, color: context.colorTheme.orangePomegranade) : null,
                    onTap: () async {
                      if (!isFirstTimeMode) {
                        Navigator.pop(context, code);
                        Logger().d("returning language: $code");
                      } else {
                        Logger().d("setting preferred language locally: $code");
                        await ref
                            .read(preferredLanguageRepositoryProvider.notifier)
                            .setPreferredLanguage(SolvroLocale.values.byName(code));
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
