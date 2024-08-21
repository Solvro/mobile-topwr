import "package:flutter/widgets.dart";
import "../../config/map_view_config.dart";
import "../../utils/contains_lower_case.dart";
import "../../utils/context_extensions.dart";

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
