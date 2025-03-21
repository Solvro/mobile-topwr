import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../utils/datetime_utils.dart";

part "sks_chart_data.freezed.dart";
part "sks_chart_data.g.dart";

@freezed
abstract class SksChartData with _$SksChartData {
  const factory SksChartData({
    required int activeUsers,
    required int movingAverage21,
    @JsonKey(fromJson: fromJsonToLocalTime) required DateTime externalTimestamp,
  }) = _SksChartData;

  factory SksChartData.fromJson(Map<String, dynamic> json) => _$SksChartDataFromJson(json);
}

// DateTime toLocalPolish(String dateTimeString) {
//   return DateTime.parse(dateTimeString).toUtc().toLocal();
// }

extension SksChartDataIListX on IList<SksChartData> {
  double get maxNumberOfUsers {
    return map(
      (data) => data.activeUsers > data.movingAverage21 ? data.activeUsers : data.movingAverage21,
    ).reduce((a, b) => a > b ? a : b).toDouble();
  }
}
