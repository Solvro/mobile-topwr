import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/contains_number.dart";
import "../repository/buildings_repository.dart";

part "building_codes_utils.g.dart";

@riverpod
Future<ISet<String>> allBuildingsCodesLowerCase(Ref ref) async {
  final buildings = await ref.watch(buildingsRepositoryProvider.future);
  return buildings
      .map((e) => e.parseBuildingCode?.toLowerCase())
      .whereType<String>()
      .toISet();
}

extension IsStringABuildingCodeX on Ref {
  bool isStringABuildingCode(String potentialBuildingCode) {
    final allLowerCaseBuildingsCodes =
        watch(allBuildingsCodesLowerCaseProvider).requireValue;
    return allLowerCaseBuildingsCodes
            .contains(potentialBuildingCode.toLowerCase()) ||
        potentialBuildingCode.containsNumber();
  }
}
