import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/simple_previews/preview_card_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "preview_card_loading_square.stories.g.dart";

class PreviewCardLoadingSquareStory extends StatelessWidget {
  const PreviewCardLoadingSquareStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewCardLoading.square(size: 100);
  }
}

const meta = Meta(PreviewCardLoadingSquareStory.new);

final $square = PreviewCardLoadingSquareStoryStory();
