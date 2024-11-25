import "package:fast_immutable_collections/fast_immutable_collections.dart";

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

  factory SksChartData.fromJson(Map<String, dynamic> json) =>
      _$SksChartDataFromJson(json);
}

extension SksChartDataIListX on IList<SksChartData> {
  double get maxNumberOfUsers {
    return map(
      (data) => data.activeUsers > data.movingAverage21
          ? data.activeUsers
          : data.movingAverage21,
    ).reduce((a, b) => a > b ? a : b).toDouble();
  }
}
