import "package:flutter/material.dart";

extension CalculateLinesX on TextSpan {
  int calculateLines(
    double availableWidth, {
    List<PlaceholderDimensions>? placeholderDimensions,
  }) {
    final textPainter = TextPainter(
      text: this,
      textDirection: TextDirection.ltr,
    );

    if (placeholderDimensions != null) {
      textPainter.setPlaceholderDimensions(placeholderDimensions);
    }

    return (textPainter..layout(maxWidth: availableWidth))
        .computeLineMetrics()
        .length;
  }
}
