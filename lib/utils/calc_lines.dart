import 'package:flutter/material.dart';

extension CalcLinesUIUtils on TextSpan {
  int calculateLines(double availableWidth) {
    final textPainter = TextPainter(
      text: this,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: availableWidth);
    return textPainter.computeLineMetrics().length;
  }
}