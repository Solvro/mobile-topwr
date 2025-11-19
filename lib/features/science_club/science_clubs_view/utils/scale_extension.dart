enum ScaleType { scaleLow, scaleMedium, scaleHigh, scaleExtraHigh }

extension ScaleTypeX on double {
  ScaleType get scaleType {
    if (this < 1.3) {
      return ScaleType.scaleMedium;
    } else if (this < 1.5) {
      return ScaleType.scaleHigh;
    } else {
      return ScaleType.scaleExtraHigh;
    }
  }
}

({int titleMaxLines, int tagsMaxLines}) calculateMaxLines({
  required ScaleType scaleType,
  required bool hasTags,
  required int titleLines,
}) {
  if (scaleType == ScaleType.scaleMedium) {
    return (titleMaxLines: 3, tagsMaxLines: titleLines <= 2 ? 2 : 1);
  } else if (scaleType == ScaleType.scaleHigh) {
    return (titleMaxLines: (!hasTags) ? 3 : 2, tagsMaxLines: titleLines == 1 ? 2 : 1);
  } else {
    return (titleMaxLines: 2, tagsMaxLines: 0);
  }
}
