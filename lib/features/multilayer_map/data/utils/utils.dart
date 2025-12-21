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

extension SortByCodeOrderX on IList<Building> {
  IList<Building> sortByCodeOrder() {
    const prioritizedCodes = [
      "a-1",
      "b-1",
      "b-4",
      "b-5",
      "c-1",
      "c-2",
      "c-3",
      "c-4",
      "c-5",
      "c-6",
      "c-13",
      "c-16",
      "c-18",
      "c-19",
      "c-20",
      "d-1",
      "d-2",
      "d-20",
      "d-21",
      "e-1",
      "h-4",
      "h-14",
      "l-1",
      "p-22",
      "p-23",
    ];

    return sort((a, b) {
      final nameA = a.name.toLowerCase();
      final nameB = b.name.toLowerCase();

      final indexA = prioritizedCodes.indexOf(nameA);
      final indexB = prioritizedCodes.indexOf(nameB);

      if (indexA != -1 && indexB != -1) {
        return indexA.compareTo(indexB);
      } else if (indexA != -1) {
        return -1; 
      } else if (indexB != -1) {
        return 1; 
      } else {
        
        return _compareCodes(a, b);
      }
    });
  }

  int _compareCodes(Building a, Building b) {
    final codeA = a.name.split(BuildingSearchConfig.buildingCodeSeperator);
    final codeB = b.name.split(BuildingSearchConfig.buildingCodeSeperator);
    final prefixA = codeA[0].toLowerCase();
    final prefixB = codeB[0].toLowerCase();

    if (prefixA == prefixB) {
      return codeA[1].tryParseInt().compareTo(codeB[1].tryParseInt());
    } else {
      return prefixA.compareTo(prefixB);
    }
  }
}

extension _TryParseIntX on String {
  int tryParseInt() {
    return int.tryParse(this) ?? 0;
  }
}
