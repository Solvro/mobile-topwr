import "package:flutter/material.dart";
import "package:topwr/widgets/detail_views/pop_button.dart";
import "package:widgetbook/widgetbook.dart";

part "detail_view_pop_button_icon_only.stories.g.dart";

class DetailViewPopButtonIconOnlyStory extends StatelessWidget {
  const DetailViewPopButtonIconOnlyStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: DetailViewPopButton());
  }
}

const meta = Meta<DetailViewPopButtonIconOnlyStory>();

final $iconOnly = DetailViewPopButtonIconOnlyStoryStory();
