import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/models/digital_guide_response.dart";
import "../../data/repository/entraces_repository.dart";
import "../models/digital_guide_entrace.dart";

part "entrances_use_cases.g.dart";

final selectedEntranceProvider =
    StateProvider<DigitalGuideEntrace?>((ref) => null);

@riverpod
Future<IList<DigitalGuideEntrace>> getEntrancesUseCase(
  Ref ref,
  DigitalGuideResponse digitalGuideData,
) async {
  final entrances =
      await ref.watch(entrancesRepositoryProvider(digitalGuideData).future);

  return entrances.where((entrance) {
    //return entrance.isMain;
    return true;
  }).toIList();
}
