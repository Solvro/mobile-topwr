import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_carousel.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_carousel_with_indicator.stories.g.dart";

final _mockImgListId = IList<int>(const [101, 102, 103]);

const meta = Meta<DigitalGuideCarouselWithIndicator>();

final $default = DigitalGuideCarouselWithIndicatorStory(
  args: DigitalGuideCarouselWithIndicatorArgs(imgListId: Arg.fixed(_mockImgListId)),
);
