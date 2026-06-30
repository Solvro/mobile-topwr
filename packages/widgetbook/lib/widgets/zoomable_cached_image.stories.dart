import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:topwr/widgets/zoomable_images.dart";
import "package:widgetbook/widgetbook.dart";
import "../widgetbook_placeholders.dart";

part "zoomable_cached_image.stories.g.dart";

class ZoomableCachedImageStoryKnobs {
  final String imageUrl;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;
  final String semanticsLabel;
  ZoomableCachedImageStoryKnobs({
    required this.imageUrl,
    required this.loadingType,
    required this.boxFit,
    required this.shouldHaveRectBackground,
    required this.semanticsLabel,
  });
}

const meta = Meta(ZoomableCachedImage.new, argsType: ZoomableCachedImageStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => ZoomableCachedImage(
    args.imageUrl,
    loadingType: args.loadingType,
    boxFit: args.boxFit,
    shouldHaveRectBackground: args.shouldHaveRectBackground,
    semanticsLabel: args.semanticsLabel,
  ),
);

final $default = ZoomableCachedImageStory(
  args: ZoomableCachedImageStoryKnobsArgs(
    imageUrl: StringArg(widgetbookPlaceholderImageUrl),
    semanticsLabel: StringArg("Zoomable campus image"),
  ),
);
