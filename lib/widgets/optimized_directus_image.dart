import "package:flutter/material.dart";

import "../api_base/directus_assets_url.dart";
import "my_cached_image.dart";

/// It requests image from Directus already with the size of a parent widget. (less data to download)
class OptimizedDirectusImage extends MyCachedImage {
  const OptimizedDirectusImage(
    super.imageUrl, {
    super.key,
    super.boxFit,
    super.noShimmeringLoading,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(
          constraints.maxWidth != double.infinity,
          "MaxWidth constraints around `OptimizedDirectusImage` must be finite. Either wrap it inside a parent with a finite width or use `MyCachedImage` directly.",
        );
        assert(
          constraints.maxHeight != double.infinity,
          "MaxHeight constraints around `OptimizedDirectusImage` must be finite. Either wrap it inside a parent with a finite height or use `MyCachedImage` directly.",
        );
        final pixelsDensity = MediaQuery.devicePixelRatioOf(context);
        return _LoadSizeOnce(
          initialSize: Size(
            constraints.maxWidth * pixelsDensity,
            constraints.maxHeight * pixelsDensity,
          ),
          builder: (BuildContext context, Size size) => MyCachedImage(
            imageUrl?.directusUrlWithSize(size, boxFit),
            noShimmeringLoading: noShimmeringLoading,
            boxFit: boxFit,
            size: size,
          ),
        );
      },
    );
  }
}

/// This StatefulWidget will build its child once with the initial size and won't rebuild it it if the size changes.
/// If we wouldn't use it, the `OptimizedDirectusImage` would rebuild on every layout change, causing fetching of a new image (of new size).
class _LoadSizeOnce extends StatefulWidget {
  const _LoadSizeOnce({
    required this.initialSize,
    required this.builder,
  });
  final Widget Function(BuildContext context, Size size) builder;
  final Size initialSize;
  @override
  State<_LoadSizeOnce> createState() => _LoadSizeOnceState();
}

class _LoadSizeOnceState extends State<_LoadSizeOnce> {
  late Size size;
  @override
  void initState() {
    size = widget.initialSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, size);
  }
}
