import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/guide_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "guide_detail_view.stories.g.dart";

const meta = Meta<GuideDetailView>();

final $default = GuideDetailViewStory(
  name: "Production view with hardcoded data",
  args: GuideDetailViewArgs.fixed(id: 2),
);
