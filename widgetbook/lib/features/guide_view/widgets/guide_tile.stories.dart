import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/guide_view/data/models/guide_data.dart";
import "package:topwr/features/guide_view/widgets/guide_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "guide_tile.stories.g.dart";

const _mockImageData = ImageData(url: "https://example.com/image.png");

const _mockGuideData = GuideData(
  id: 1,
  title: "Guide Title",
  shortDesc: "This is a short description of the guide.",
  image: _mockImageData,
);

const meta = Meta<GuideTile>();

final $default = GuideTileStory(args: GuideTileArgs(item: Arg.fixed(_mockGuideData)));
