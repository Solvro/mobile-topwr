import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'parking_model.dart';

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

extension FlChartUtilities on ChartData {
  static const chartMargin = 20;

  Text getLabelForIndex(double index, _) {
    return Text(labels[index.toInt()]);
  }

  FlSpot? getPointForIndex(int index, _) {
    final freePlacesNumber = double.tryParse(data[index]);
    if (freePlacesNumber == null) return null;
    return FlSpot(index.toDouble(), freePlacesNumber);
  }

  double get maxX => max(0, labels.length - 1).toDouble();

  double maxY(ParkingPlace parkingPlace) => max(
        double.tryParse(parkingPlace.places) ?? 0,
        data.map((e) => double.tryParse(e) ?? 0).toList().max + chartMargin,
      );
}
