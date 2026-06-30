import "package:flutter/widgets.dart";
import "package:topwr/features/settings/widgets/language_settings_dialog.dart";
import "package:widgetbook/widgetbook.dart";

part "language_dialog_first_time.stories.g.dart";

class LanguageDialogFirstTimeStory extends StatelessWidget {
  const LanguageDialogFirstTimeStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const LanguageDialog(isFirstTimeMode: true);
  }
}

const meta = Meta(LanguageDialogFirstTimeStory.new);

final $firstTime = LanguageDialogFirstTimeStoryStory();
