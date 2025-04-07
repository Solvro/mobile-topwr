import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog();

  static Future<String?> show(BuildContext context) async {
    return showDialog<String>(context: context, builder: (context) => const LanguageDialog());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = context.localize.localeName;
    final languages = [
      (context.localize.polish_id, context.localize.polish_title),
      (context.localize.english_id, context.localize.english_title),
    ];
    return RedDialog(
      title: context.localize.language,
      subtitle: null,
      showApplyButton: false,
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
                onTap: () {
                  Navigator.pop(context, code);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
