import "dart:math";

import "package:flutter/material.dart";

import "../config/ui_config.dart";

double useFiltersSheetHeight(
  BuildContext context, {
  double prefferedHeightFactor = FilterConfig.bottomSheetHeightFactor,
  double? width,
}) {
  final height = MediaQuery.sizeOf(context).height;

  final maximumHeight =
      FilterConfig.absoluteMaximumBottomSheetHeightFactor * height;

  if (width != null && width > 600) {
    return maximumHeight;
  }

  return min(
    maximumHeight,
    max(
      height * prefferedHeightFactor,
      FilterConfig.minimalHeight,
    ),
  );
}
