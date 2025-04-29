import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../../utils/context_extensions.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({required this.isFirstTimeMode, super.key});

  final bool isFirstTimeMode;

  static Future<String?> show(BuildContext context, {bool isFirstTimeMode = false}) async {
    return showDialog<String>(context: context, builder: (context) => LanguageDialog(isFirstTimeMode: isFirstTimeMode));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = context.localize.localeName;
    final languages = [
      (context.localize.polish_id, context.localize.polish_title),
      (context.localize.english_id, context.localize.english_title),
    ];
    return RedDialog(
      centerTitle: isFirstTimeMode,
      title: isFirstTimeMode ? context.localize.select_language : context.localize.language,
      subtitle: null,
      showApplyButton: isFirstTimeMode,
      applyButtonText: context.localize.select,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
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
                title: Text(name),
                trailing: selected ? Icon(Icons.check, color: context.colorTheme.orangePomegranade) : null,
                onTap: () async {
                  if (!isFirstTimeMode) {
                    Navigator.pop(context, code);
                  } else {
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
    );
  }
}
