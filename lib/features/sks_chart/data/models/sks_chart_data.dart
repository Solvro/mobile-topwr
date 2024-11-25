
import "package:freezed_annotation/freezed_annotation.dart";

part "sks_chart_data.freezed.dart";
part "sks_chart_data.g.dart";

@freezed
class SksChartData with _$SksChartData {
  const factory SksChartData({
    required int activeUsers,
    required int movingAverage21,
    required DateTime externalTimestamp
}) = _SksChartData;

  factory SksChartData.fromJson(Map<String,dynamic> json) =>
      _$SksChartDataFromJson(json);
}