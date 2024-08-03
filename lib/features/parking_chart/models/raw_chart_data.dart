import "package:freezed_annotation/freezed_annotation.dart";

part "raw_chart_data.freezed.dart";
part "raw_chart_data.g.dart";

@freezed
class RawChartData with _$RawChartData {
  const factory RawChartData({
    required List<String> data,
    required List<String> labels,
  }) = _RawChartData;

  factory RawChartData.fromJson(Map<String, dynamic> json) =>
      _$RawChartDataFromJson(json);
}
