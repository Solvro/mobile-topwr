import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:topwr/widgets/zoomable_images.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _sampleImageUrls = <String>[
  "https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=1200",
  "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1200",
  "https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1200",
];

@widgetbook.UseCase(name: "default", type: ZoomableCachedImage)
Widget useCaseZoomableCachedImage(BuildContext context) {
  return ZoomableCachedImage(
    context.knobs.object.dropdown(
      label: "Image url",
      options: _sampleImageUrls,
      initialOption: _sampleImageUrls.first,
    ),
    loadingType: context.knobs.object.dropdown(label: "Loading type", options: LoadingType.values),
    boxFit: context.knobs.object.dropdown(label: "Box fit", options: BoxFit.values),
    shouldHaveRectBackground: context.knobs.boolean(label: "Should have rect background"),
    semanticsLabel: context.knobs.string(label: "Semantics label", initialValue: "Sample zoomable landscape image"),
  );
}
