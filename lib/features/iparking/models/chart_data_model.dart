import 'package:freezed_annotation/freezed_annotation.dart';

part "chart_data_model.freezed.dart";
part "chart_data_model.g.dart";

@freezed
class ChartData with _$ChartData {
  const factory ChartData({
    required List<String> data,
    required List<String> labels,
  }) = _ChartData;

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);
}
