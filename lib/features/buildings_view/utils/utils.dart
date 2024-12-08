import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../config/map_view_config.dart";
import "../../../utils/contains_lower_case.dart";
import "../../../utils/context_extensions.dart";
import "../model/building_model.dart";

extension ContainsCaseUnsensitiveX on String? {
  bool containsBuildingCode(String buildingCode) {
    if (buildingCode.contains(BuildingSearchConfig.buildingCodeSeperator)) {
      return containsLowerCase(buildingCode);
    }
    return (this?.replaceAll(BuildingSearchConfig.buildingCodeSeperator, ""))
        .containsLowerCase(buildingCode);
  }
}

extension ChangeNullAdressX on BuildContext {
  String? changeNull(String? address) {
    return address ?? localize.no_address;
  }
}

extension SortByCodeOrderX on IList<BuildingModel> {
  IList<BuildingModel> sortByCodeOrder() {
    return sort((a, b) {
      if (a.disableBuildingPrefix != b.disableBuildingPrefix) {
        return (a.disableBuildingPrefix ? 1 : -1);
      } else {
        return _compareCodes(a, b);
      }
    });
  }

  int _compareCodes(BuildingModel a, BuildingModel b) {
    final codeA = a.name.split(BuildingSearchConfig.buildingCodeSeperator);
    final codeB = b.name.split(BuildingSearchConfig.buildingCodeSeperator);
    if (codeA[0] == codeB[0]) {
      return codeA[1].tryParseInt().compareTo(codeB[1].tryParseInt());
    } else {
      return codeA[0].compareTo(codeB[0]);
    }
  }
}

extension _TryParseIntX on String {
  int tryParseInt() {
    return int.tryParse(this) ?? 0;
  }
}
