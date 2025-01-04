import "dart:math";

import "package:flutter/material.dart";

import "../config/ui_config.dart";

double useFiltersSheetHeight(
  BuildContext context, {
  double prefferedHeightFactor = FilterConfig.bottomSheetHeightFactor,
}) {
  final height = MediaQuery.sizeOf(context).height;
  return min(
    FilterConfig.absoluteMaximumBottomSheetHeightFactor * height,
    max(
      height * prefferedHeightFactor,
      FilterConfig.minimalHeight,
    ),
  );
}
