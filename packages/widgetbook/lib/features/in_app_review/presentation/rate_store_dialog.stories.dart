import "package:flutter/widgets.dart";
import "package:topwr/features/in_app_review/presentation/rate_store_dialog.dart";
import "package:widgetbook/widgetbook.dart";

part "rate_store_dialog.stories.g.dart";

class RateStoreDialogContentStory extends StatelessWidget {
  const RateStoreDialogContentStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const RateStoreDialogContent();
  }
}

const meta = Meta(RateStoreDialogContentStory.new);

final $default = RateStoreDialogContentStoryStory();
