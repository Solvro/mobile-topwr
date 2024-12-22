import "dart:math";

import "package:flutter/material.dart";

import "../config/ui_config.dart";

double useFiltersSheetHeight(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  return min(
    FilterConfig.absoluteMaximumBottomSheetHeightFactor * height,
    max(
      height * FilterConfig.bottomSheetHeightFactor,
      FilterConfig.minimalHeight,
    ),
  );
}
