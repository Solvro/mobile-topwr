import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyCachedImage)
Widget useCaseMyCachedImage(BuildContext context) {
  return MyCachedImage(
    context.knobs.stringOrNull(label: "Image url"),
    loadingType: context.knobs.object.dropdown(label: "Loading type", options: LoadingType.values),
    boxFit: context.knobs.object.dropdown(label: "Box fit", options: BoxFit.values),
    size: context.knobs.objectOrNull.dropdown(label: "Size", options: <Size>[]),
    semanticsLabel: context.knobs.stringOrNull(label: "Semantics label"),
  );
}
