import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:topwr/widgets/zoomable_images.dart";
import "package:widgetbook/widgetbook.dart";

part "zoomable_rest_api_image.stories.g.dart";

const _mockImageData = ImageData(url: "");

class ZoomableRestApiImageStoryKnobs {
  final ImageData imageData;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;
  final String semanticsLabel;
  final bool useFullImageQuality;
  ZoomableRestApiImageStoryKnobs({
    required this.imageData,
    required this.loadingType,
    required this.boxFit,
    required this.shouldHaveRectBackground,
    required this.semanticsLabel,
    required this.useFullImageQuality,
  });
}

const meta = MetaWithArgs<ZoomableRestApiImage, ZoomableRestApiImageStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => ZoomableRestApiImage(
    args.imageData,
    loadingType: args.loadingType,
    boxFit: args.boxFit,
    shouldHaveRectBackground: args.shouldHaveRectBackground,
    semanticsLabel: args.semanticsLabel,
    useFullImageQuality: args.useFullImageQuality,
  ),
);

final $default = ZoomableRestApiImageStory(
  args: ZoomableRestApiImageStoryKnobsArgs(imageData: Arg.fixed(_mockImageData)),
);
