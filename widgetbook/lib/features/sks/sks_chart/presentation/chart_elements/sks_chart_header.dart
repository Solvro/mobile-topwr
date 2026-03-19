import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart_header.dart";
import "package:topwr/features/sks/sks_people_live/data/models/sks_user_data.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksChartHeader)
Widget useCaseSksChartHeader(BuildContext context) {
  return SksChartHeader(
    numberOfPeople: context.knobs.string(label: "Number of People", initialValue: "121"),
    trend: context.knobs.object.dropdown(label: "Trend", options: Trend.values),
  );
}
