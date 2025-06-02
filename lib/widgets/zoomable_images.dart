import "package:flutter/material.dart";

import "../api_base/directus_assets_url.dart";
import "../theme/colors.dart";
import "../utils/context_extensions.dart";
import "my_cached_image.dart";
import "optimized_directus_image.dart";

extension ShowFullscreenImageX on BuildContext {
  Future<void> showFullScreenImage(String? imageUrl, {bool shouldHaveRectBackground = false}) async {
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
            label: context.localize.logotype,
            child: Focus(
              autofocus: true,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child:
                    shouldHaveRectBackground
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
        child: MyCachedImage(
          imageUrl?.directusUrlWithoutParams,
          boxFit: BoxFit.scaleDown,
          loadingType: LoadingType.circularProgressIndicator,
        ),
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
                imageUrl?.directusUrlWithoutParams,
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

class ZoomableOptimizedDirectusImage extends StatelessWidget {
  const ZoomableOptimizedDirectusImage(
    this.imageUrl, {
    super.key,
    this.loadingType = LoadingType.shimmerLoading,
    this.boxFit = BoxFit.cover,
    this.shouldHaveRectBackground = false,
  });

  final String? imageUrl;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.showFullScreenImage(imageUrl, shouldHaveRectBackground: shouldHaveRectBackground);
      },
      child: OptimizedDirectusImage(imageUrl, boxFit: boxFit, loadingType: loadingType),
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
  });

  final String? imageUrl;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.showFullScreenImage(imageUrl, shouldHaveRectBackground: shouldHaveRectBackground);
      },
      child: MyCachedImage(imageUrl, boxFit: boxFit, loadingType: loadingType),
    );
  }
}
