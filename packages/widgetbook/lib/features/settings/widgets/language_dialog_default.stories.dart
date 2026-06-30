import "package:flutter/widgets.dart";
import "package:topwr/features/settings/widgets/language_settings_dialog.dart";
import "package:widgetbook/widgetbook.dart";

part "language_dialog_default.stories.g.dart";

class LanguageDialogDefaultStory extends StatelessWidget {
  const LanguageDialogDefaultStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const LanguageDialog(isFirstTimeMode: false);
  }
}

const meta = Meta(LanguageDialogDefaultStory.new);

final $default = LanguageDialogDefaultStoryStory();
