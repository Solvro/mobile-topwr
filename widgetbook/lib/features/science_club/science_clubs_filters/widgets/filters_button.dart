import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filters_button.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FiltersButton)
Widget useCaseFiltersButton(BuildContext context) {
  return FiltersButton(
    text: context.knobs.string(label: "Text", initialValue: "Text"),
    icon: context.knobs.object.dropdown(label: "Icon", options: [Icons.info, Icons.home, Icons.settings]),
    onPressed: () {},
    isSecondary: context.knobs.boolean(label: "Is secondary"),
  );
}
