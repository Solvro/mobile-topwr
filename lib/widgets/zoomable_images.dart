import "package:flutter/material.dart";

import "../api_base_rest/shared_models/image_data.dart";
import "../theme/colors.dart";
import "../utils/context_extensions.dart";
import "my_cached_image.dart";

extension ShowFullscreenImageX on BuildContext {
  Future<void> showFullScreenImage(
    String? imageUrl, {
    bool shouldHaveRectBackground = false,
    String? semanticsLabel,
  }) async {
    if (imageUrl == null) {
      return;
    }
    await showDialog<void>(
      context: this,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Semantics(
            container: true,
            image: true,
            button: false,
            label: (semanticsLabel ?? "") + context.localize.fullscreen_image,
            child: Focus(
              autofocus: true,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: shouldHaveRectBackground
                    ? _ImageWithWhiteBackground(imageUrl: imageUrl)
                    : _ImageWithoutBackground(imageUrl: imageUrl),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ImageWithoutBackground extends StatelessWidget {
  const _ImageWithoutBackground({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MyCachedImage(imageUrl, boxFit: BoxFit.scaleDown, loadingType: LoadingType.circularProgressIndicator),
      ),
    );
  }
}

class _ImageWithWhiteBackground extends StatelessWidget {
  const _ImageWithWhiteBackground({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(color: ColorsConsts.greyLight, borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.sizeOf(context).shortestSide,
            height: MediaQuery.sizeOf(context).shortestSide,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: MyCachedImage(
                imageUrl,
                boxFit: BoxFit.scaleDown,
                loadingType: LoadingType.circularProgressIndicator,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ZoomableCachedImage extends StatelessWidget {
  const ZoomableCachedImage(
    this.imageUrl, {
    super.key,
    this.loadingType = LoadingType.shimmerLoading,
    this.boxFit = BoxFit.cover,
    this.shouldHaveRectBackground = false,
    this.semanticsLabel,
  });

  final String? imageUrl;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;
  final String? semanticsLabel;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      image: true,
      button: false,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTap: () async {
            await context.showFullScreenImage(
              imageUrl,
              shouldHaveRectBackground: shouldHaveRectBackground,
              semanticsLabel: semanticsLabel,
            );
          },
          child: MyCachedImage(imageUrl, boxFit: boxFit, loadingType: loadingType, semanticsLabel: semanticsLabel),
        ),
      ),
    );
  }
}

/// Widget that displays a zoomable image from [ImageData].
/// Shows the miniature (effectiveUrl) in preview, but full resolution (url) when zoomed.
class ZoomableRestApiImage extends StatelessWidget {
  const ZoomableRestApiImage(
    this.imageData, {
    super.key,
    this.loadingType = LoadingType.shimmerLoading,
    this.boxFit = BoxFit.cover,
    this.shouldHaveRectBackground = false,
    this.semanticsLabel,
    this.useFullImageQuality = false,
  });

  final ImageData? imageData;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;
  final String? semanticsLabel;
  final bool useFullImageQuality;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      image: true,
      button: false,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTap: () async {
            await context.showFullScreenImage(
              imageData?.url,
              shouldHaveRectBackground: shouldHaveRectBackground,
              semanticsLabel: semanticsLabel,
            );
          },
          child: MyCachedImage(
            useFullImageQuality ? imageData?.url : imageData?.effectiveUrl,
            boxFit: boxFit,
            loadingType: loadingType,
            semanticsLabel: semanticsLabel,
          ),
        ),
      ),
    );
  }
}
