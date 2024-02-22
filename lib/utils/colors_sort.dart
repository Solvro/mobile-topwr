import 'package:flutter/material.dart';

extension ColorsSortExt on List<Color> {
  void sortByLightness() {
    sort(
      (a, b) {
        final lightnes1 = HSLColor.fromColor(a).lightness;
        final lightnes2 = HSLColor.fromColor(b).lightness;
        return lightnes1.compareTo(lightnes2);
      },
    );
  }
}
