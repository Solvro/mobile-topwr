import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/guide_view/data/models/guide_data.dart";
import "package:topwr/features/guide_view/widgets/guide_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../widgetbook_placeholders.dart";

part "guide_tile.stories.g.dart";

const _mockImageData = ImageData(url: widgetbookPlaceholderImageUrl);

const _mockGuideData = GuideData(
  id: 2,
  title: "Zapisy na zajęcia",
  shortDesc: "Wszystko o rejestracji na przedmioty na naszej uczelni.",
  image: _mockImageData,
);

const meta = Meta(GuideTile.new);

final $default = GuideTileStory(args: GuideTileArgs(item: Arg.fixed(_mockGuideData)));
