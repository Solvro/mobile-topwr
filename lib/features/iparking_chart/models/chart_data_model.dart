import "package:freezed_annotation/freezed_annotation.dart";

part "chart_data_model.freezed.dart";
part "chart_data_model.g.dart";

@freezed
class RawChartData with _$RawChartData {
  const factory RawChartData({
    required List<String> data,
    required List<String> labels,
  }) = _ChartData;

  factory RawChartData.fromJson(Map<String, dynamic> json) =>
      _$RawChartDataFromJson(json);
}
