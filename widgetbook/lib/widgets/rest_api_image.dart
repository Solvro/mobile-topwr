import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:topwr/widgets/rest_api_image.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RestApiImage)
Widget useCaseRestApiImage(BuildContext context) {
  return RestApiImage(
    context.knobs.objectOrNull.dropdown(label: "Image data", options: <ImageData>[]),
    loadingType: context.knobs.object.dropdown(label: "Loading type", options: LoadingType.values),
    boxFit: context.knobs.object.dropdown(label: "Box fit", options: BoxFit.values),
    size: context.knobs.objectOrNull.dropdown(label: "Size", options: <Size>[]),
    semanticsLabel: context.knobs.stringOrNull(label: "Semantics label"),
    useFullImageQuality: context.knobs.boolean(label: "Use full image quality"),
  );
}
