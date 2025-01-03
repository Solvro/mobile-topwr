import "dart:math";

import "package:flutter/material.dart";

import "../config/ui_config.dart";

double useFiltersSheetHeight(BuildContext context, {double? prefferedHeight}) {
  final height = MediaQuery.sizeOf(context).height;
  return min(
    FilterConfig.absoluteMaximumBottomSheetHeightFactor * height,
    max(
      prefferedHeight ?? (height * FilterConfig.bottomSheetHeightFactor),
      FilterConfig.minimalHeight,
    ),
  );
}
