import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "raw_chart_data.freezed.dart";
part "raw_chart_data.g.dart";

@freezed
abstract class RawChartData with _$RawChartData {
  const factory RawChartData({required IList<String> data, required IList<String> labels}) = _RawChartData;

  factory RawChartData.fromJson(Map<String, dynamic> json) => _$RawChartDataFromJson(json);
}
