import "package:flutter/material.dart";

class RectThumbShape extends SliderComponentShape {
  const RectThumbShape({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(width, height);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Color color =
        ColorTween(begin: sliderTheme.disabledThumbColor, end: sliderTheme.thumbColor).evaluate(enableAnimation) ??
        Colors.white;

    final paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final rect = Rect.fromCenter(center: center, width: width, height: height);

    canvas.drawRect(rect, paint);
  }
}
