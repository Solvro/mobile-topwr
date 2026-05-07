import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:topwr/widgets/rest_api_image.dart";
import "package:widgetbook/widgetbook.dart";

part "rest_api_image.stories.g.dart";

class RestApiImageStoryKnobs {
  final ImageData? imageData;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final Size? size;
  final String? semanticsLabel;
  final bool useFullImageQuality;
  RestApiImageStoryKnobs({
    this.imageData,
    required this.loadingType,
    required this.boxFit,
    this.size,
    this.semanticsLabel,
    required this.useFullImageQuality,
  });
}

const meta = MetaWithArgs<RestApiImage, RestApiImageStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => RestApiImage(
    args.imageData,
    loadingType: args.loadingType,
    boxFit: args.boxFit,
    size: args.size,
    semanticsLabel: args.semanticsLabel,
    useFullImageQuality: args.useFullImageQuality,
  ),
);

final $default = RestApiImageStory();
