import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../api_base/directus_assets_url.dart";
import "../hooks/use_effect_on_init.dart";
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
        _assertConstraints(constraints);

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

  void _assertConstraints(BoxConstraints constraints) {
    assert(
      constraints.maxWidth != double.infinity,
      "MaxWidth constraints around `OptimizedDirectusImage` must be finite. Either wrap it inside a parent with a finite width or use `MyCachedImage` directly.",
    );
    assert(
      constraints.maxHeight != double.infinity,
      "MaxHeight constraints around `OptimizedDirectusImage` must be finite. Either wrap it inside a parent with a finite height or use `MyCachedImage` directly.",
    );
  }
}

/// This HookWidget will build its child once with the initial size and won't rebuild it if the size changes.
/// If we wouldn't use it, the `OptimizedDirectusImage` would rebuild on every layout change, causing fetching of a new image (of new size).
class _LoadSizeOnce extends HookWidget {
  const _LoadSizeOnce({
    required this.initialSize,
    required this.builder,
  });
  final Widget Function(BuildContext context, Size size) builder;
  final Size initialSize;

  @override
  Widget build(BuildContext context) {
    final size = useState(Size.zero);
    useEffectOnInit(
      () {
        size.value = initialSize;
        return null;
      },
    );
    return builder(context, size.value);
  }
}
