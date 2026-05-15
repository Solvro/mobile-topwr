import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../config/map_view_config.dart";
import "../../../../utils/contains_lower_case.dart";
import "../../../../utils/context_extensions.dart";
import "../model/building.dart";

extension ContainsCaseUnsensitiveX on String? {
  bool containsBuildingCode(String buildingCode) {
    if (buildingCode.contains(BuildingSearchConfig.buildingCodeSeperator)) {
      return containsLowerCase(buildingCode);
    }
    return (this?.replaceAll(BuildingSearchConfig.buildingCodeSeperator, "")).containsLowerCase(buildingCode);
  }
}

extension ChangeNullAdressX on BuildContext {
  String? changeNull(String? address) {
    return address ?? localize.no_address;
  }
}

int compareBuildingCodes(Building a, Building b) {
  final codeA = a.name.split(BuildingSearchConfig.buildingCodeSeperator);
  final codeB = b.name.split(BuildingSearchConfig.buildingCodeSeperator);
  if (codeA[0] == codeB[0]) {
    return codeA[1].tryParseInt().compareTo(codeB[1].tryParseInt());
  } else {
    return codeA[0].compareTo(codeB[0]);
  }
}

int compareBuildingsNullable(Building? a, Building? b) {
  if (a == null && b == null) {
    return 0;
  }
  if (a == null) {
    return 1;
  }
  if (b == null) {
    return -1;
  }
  return compareBuildingCodes(a, b);
}

extension SortByCodeOrderX on IList<Building> {
  IList<Building> sortByCodeOrder() {
    return sort(compareBuildingCodes);
  }
}

extension SortByAssociatedBuildingX<T> on IList<T> {
  IList<T> sortByAssociatedBuilding({
    required Building? Function(T item) buildingOf,
    required int Function(T a, T b) tieBreaker,
  }) {
    return sort((a, b) {
      final buildingComparison = compareBuildingsNullable(buildingOf(a), buildingOf(b));
      if (buildingComparison != 0) {
        return buildingComparison;
      }
      return tieBreaker(a, b);
    });
  }
}

extension _TryParseIntX on String {
  int tryParseInt() {
    return int.tryParse(this) ?? 0;
  }
}
