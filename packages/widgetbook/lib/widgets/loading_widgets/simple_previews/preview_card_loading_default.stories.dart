import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/simple_previews/preview_card_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "preview_card_loading_default.stories.g.dart";

class PreviewCardLoadingDefaultStory extends StatelessWidget {
  const PreviewCardLoadingDefaultStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewCardLoading(width: 300, height: 100);
  }
}

const meta = Meta(PreviewCardLoadingDefaultStory.new);

final $default = PreviewCardLoadingDefaultStoryStory();
