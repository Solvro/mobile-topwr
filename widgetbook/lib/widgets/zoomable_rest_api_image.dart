import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:topwr/widgets/zoomable_images.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _sampleImageData = <ImageData>[
  const ImageData(
    url: "https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=2000",
    miniaturesUrl: "https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=700",
  ),
  const ImageData(
    url: "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=2000",
    miniaturesUrl: "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=700",
  ),
];

@widgetbook.UseCase(name: "default", type: ZoomableRestApiImage)
Widget useCaseZoomableRestApiImage(BuildContext context) {
  return ZoomableRestApiImage(
    context.knobs.object.dropdown(
      label: "Image data",
      options: _sampleImageData,
      initialOption: _sampleImageData.first,
    ),
    loadingType: context.knobs.object.dropdown(label: "Loading type", options: LoadingType.values),
    boxFit: context.knobs.object.dropdown(label: "Box fit", options: BoxFit.values),
    shouldHaveRectBackground: context.knobs.boolean(label: "Should have rect background"),
    semanticsLabel: context.knobs.string(label: "Semantics label", initialValue: "Sample zoomable image"),
    useFullImageQuality: context.knobs.boolean(label: "Use full image quality"),
  );
}
