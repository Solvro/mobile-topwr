import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog();

  static Future<String?> show(BuildContext context) async {
    return showDialog<String>(context: context, builder: (context) => const LanguageDialog());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: context.colorTheme.whiteSoap,
      contentPadding: const EdgeInsets.all(AboutUsConfig.spacerHeight),
      content: StatefulBuilder(
        builder: (context, setState) {
          String selectedLanguage = context.localize.localeName;
          final languages = [
            {"code": "pl", "name": "Polski 🇵🇱"},
            {"code": "en", "name": "English 🇬🇧"},
          ];

          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.localize.language,
                  style: context.textTheme.headline.copyWith(fontSize: AboutUsConfig.dialogTitleFontSize),
                ),
                const SizedBox(height: AboutUsConfig.spacerHeight),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    final selected = selectedLanguage == lang["code"];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
                        color: context.colorTheme.greyLight,
                      ),
                      child: ListTile(
                        title: Text(lang["name"]!),
                        trailing: selected ? const Icon(Icons.check) : null,
                        selected: selected,
                        onTap: () {
                          setState(() => selectedLanguage = lang["code"]!);
                          Navigator.pop(context, lang["code"]);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: AboutUsConfig.spacerHeight),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
