import "../../config/map_view_config.dart";

extension ContainsCaseUnsensitive on String? {
  bool containsUnsesitive(String str) {
    if (this == null) return false;
    return this!.toLowerCase().contains(str.toLowerCase());
  }

  bool containsBuildingCode(String buildingCode) {
    if (buildingCode.contains(BuildingSearchConfig.buildingCodeSeperator)) {
      return containsUnsesitive(buildingCode);
    }
    return this
            ?.replaceAll(BuildingSearchConfig.buildingCodeSeperator, "")
            .containsUnsesitive(buildingCode) ??
        false;
  }
}
