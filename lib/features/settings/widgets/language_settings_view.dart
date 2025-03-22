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
    final selectedLanguage = context.localize.localeName;
    return AlertDialog(
      backgroundColor: context.colorTheme.whiteSoap,
      contentPadding: const EdgeInsets.all(AboutUsConfig.spacerHeight),
      content: StatefulBuilder(
        builder: (context, setState) {
          final languages = [("pl", "🇵🇱 Polski"), ("en", "🇬🇧 English")];

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
                    final (code, name) = languages[index];
                    final selected = selectedLanguage == code;
                    return DecoratedBox(
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
