import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart_legend.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksChartLegendItem)
Widget useCaseSksChartLegendItem(BuildContext context) {
  return SksChartLegendItem(
    text: context.knobs.string(label: "Text", initialValue: "Sample text"),
    isPredicted: context.knobs.boolean(label: "Is Predicted"),
  );
}
