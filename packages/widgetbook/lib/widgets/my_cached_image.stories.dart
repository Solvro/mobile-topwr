import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:widgetbook/widgetbook.dart";
import "../widgetbook_placeholders.dart";

part "my_cached_image.stories.g.dart";

class MyCachedImageStoryKnobs {
  final String? imageUrl;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final Size? size;
  final String? semanticsLabel;
  MyCachedImageStoryKnobs({
    this.imageUrl,
    required this.loadingType,
    required this.boxFit,
    this.size,
    this.semanticsLabel,
  });
}

const meta = Meta(MyCachedImage.new, argsType: MyCachedImageStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => MyCachedImage(
    args.imageUrl,
    loadingType: args.loadingType,
    boxFit: args.boxFit,
    size: args.size,
    semanticsLabel: args.semanticsLabel,
  ),
);

final $default = MyCachedImageStory(
  args: MyCachedImageStoryKnobsArgs(
    imageUrl: NullableStringArg(widgetbookPlaceholderImageUrl),
    semanticsLabel: NullableStringArg("Cached image preview"),
  ),
);
