import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../theme/iparking_theme.dart';
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

double _convertToNumericalRepresentation(String time) {
  List<String> parts = time.split(":");
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  return hours + (minutes / 60);
}

String _convertToStringRepresentation(double numericalTime) {
  int hours = numericalTime.floor();
  int minutes = ((numericalTime - hours) * 60).round();
  return '$hours:${minutes.toString().padLeft(2, '0')}';
}

extension FlChartUtilities on ChartData {
  static const chartMargin = 20;
  static const showLabels = [6, 8, 10, 12, 14, 16, 18, 20, 22];
  // static const showLabels = [5, 7, 9, 11, 13, 15, 17, 19, 21];

  bool checkToShowDot(FlSpot spot, LineChartBarData barData) {
    return showLabels.contains(spot.x);
  }

  Widget getLabel(double numHourValue, _) {
    if (!showLabels.contains(numHourValue)) {
      return const Text("");
    }
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        _convertToStringRepresentation(numHourValue),
        style: const ParkingTextStyle(shadows: [], fontSize: 10),
      ),
    );
  }

  FlSpot? getPointForIndex(int index, _) {
    final freePlacesNumber = double.tryParse(data[index]);
    if (freePlacesNumber == null) return null;
    final x = _convertToNumericalRepresentation(labels[index]);
    return FlSpot(x, freePlacesNumber);
  }

  double get minX => _convertToNumericalRepresentation(labels.first);
  double get maxX => _convertToNumericalRepresentation(labels.last);

  double maxY(ParkingPlace parkingPlace) => max(
        double.tryParse(parkingPlace.places) ?? 0,
        data.map((e) => double.tryParse(e) ?? 0).toList().max,
      );
}
