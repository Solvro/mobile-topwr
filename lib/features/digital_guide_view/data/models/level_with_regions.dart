import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "level.dart";
import "region.dart";

typedef LevelWithRegions = ({
  Level level,
  IList<Region> regions,
});

extension HasAdaptedToiletsX on IList<LevelWithRegions> {
  bool hasAdaptedToilets() {
    for (final level in this) {
      for (final region in level.regions) {
        if (region.adaptedToiletsIndices.isNotEmpty) {
          return true;
        }
      }
    }

    return false;
  }
}
