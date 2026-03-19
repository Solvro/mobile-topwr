import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_chart/presentation/sks_chart_sheet.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksChartSheet)
Widget useCaseSksChartSheet(BuildContext context) {
  return const SksChartSheet();
}
