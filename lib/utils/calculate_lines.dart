import "package:flutter/material.dart";

extension CalculateLinesX on TextSpan {
  int calculateLines(double availableWidth) {
    final textPainter = TextPainter(
      text: this,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: availableWidth);
    return textPainter.computeLineMetrics().length;
  }
}
