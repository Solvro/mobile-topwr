import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/widgets/big_preview_card.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BigPreviewCard)
Widget useCaseBigPreviewCard(BuildContext context) {
  return BigPreviewCard(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    shortDescription: context.knobs.string(label: "Short description", initialValue: "Short description"),
    imageData: context.knobs.objectOrNull.dropdown(label: "Image data", options: <ImageData>[]),
    date: context.knobs.dateTimeOrNull(
      label: "Date",
      initialValue: DateTime(2026, 3, 20),
      start: DateTime(2000),
      end: DateTime(2100, 12, 31),
    ),
    onClick: () {},
    boxFit: context.knobs.object.dropdown(label: "Box fit", options: BoxFit.values),
    showVerifiedBadge: context.knobs.boolean(label: "Show verified badge"),
    showStrategicBadge: context.knobs.boolean(label: "Show strategic badge"),
    imagePadding: context.knobs.objectOrNull.dropdown(label: "Image padding", options: <EdgeInsets>[]),
  );
}
