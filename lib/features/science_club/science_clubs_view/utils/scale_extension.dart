enum ScaleType { scaleLow, scaleMedium, scaleHigh, scaleExtraHigh }

extension ScaleTypeX on double {
  ScaleType get scaleType {
    if (this < 1.15) {
      return ScaleType.scaleLow;
    } else if (this < 1.3) {
      return ScaleType.scaleMedium;
    } else if (this < 1.5) {
      return ScaleType.scaleHigh;
    } else {
      return ScaleType.scaleExtraHigh;
    }
  }
}

({int titleMaxLines, int deptsMaxLines, int tagsMaxLines}) calculateMaxLines({
  required ScaleType scaleType,
  required bool hasTags,
  required bool hasDepts,
  required int titleLines,
}) {
  if (scaleType == ScaleType.scaleLow) {
    return (titleMaxLines: (!hasDepts && !hasTags) ? 3 : 2, deptsMaxLines: hasTags ? 1 : 2, tagsMaxLines: 2);
  } else if (scaleType == ScaleType.scaleMedium) {
    return (
      titleMaxLines: (!hasDepts && !hasTags) ? 3 : 2,
      deptsMaxLines: 1,
      tagsMaxLines: (!hasDepts && titleLines <= 2) || titleLines == 1 ? 2 : 1,
    );
  } else if (scaleType == ScaleType.scaleHigh) {
    return (titleMaxLines: (!hasDepts && !hasTags) ? 3 : 2, deptsMaxLines: 1, tagsMaxLines: 1);
  } else {
    return (titleMaxLines: 2, deptsMaxLines: 0, tagsMaxLines: 0);
  }
}
