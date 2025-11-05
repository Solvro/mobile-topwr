import "package:flutter/material.dart";

import "../api_base_rest/shared_models/image_data.dart";
import "my_cached_image.dart";

/// Widget that displays an image from [ImageData] using [MyCachedImage].
/// Automatically uses [ImageData.effectiveUrl] which prefers miniatures over full URL.
class RestApiImage extends StatelessWidget {
  const RestApiImage(
    this.imageData, {
    super.key,
    this.loadingType = LoadingType.shimmerLoading,
    this.boxFit = BoxFit.cover,
    this.size,
    this.semanticsLabel,
    this.useFullImageQuality = false,
  });

  final ImageData? imageData;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final Size? size;
  final String? semanticsLabel;
  final bool useFullImageQuality;

  @override
  Widget build(BuildContext context) {
    return MyCachedImage(
      useFullImageQuality ? imageData?.url : imageData?.effectiveUrl,
      loadingType: loadingType,
      boxFit: boxFit,
      size: size,
      semanticsLabel: semanticsLabel,
    );
  }
}
