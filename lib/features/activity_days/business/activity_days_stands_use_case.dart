import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/models/activity_days_stands_response.dart";
import "../data/repository/activity_days_stands_repository.dart";

part "activity_days_stands_use_case.g.dart";

typedef StandsFloor = ({DasFloor? floor, IList<DasStand> stands});

@riverpod
Future<IList<StandsFloor>> dasStandsByFloorUseCase(Ref ref) async {
  final stands = await ref.watch(dasStandsRepositoryProvider.future);
  if (stands.isEmpty) return const IListConst([]);

  final byFloor = groupBy(stands.unlock, (DasStand stand) => stand.floor?.id);

  return byFloor.entries
      .map((floor) => (floor: floor.value.first.floor, stands: floor.value.sortedBy((stand) => stand.number).toIList()))
      .sorted(_compareFloors)
      .toIList();
}

int _compareFloors(StandsFloor a, StandsFloor b) {
  final aId = a.floor?.id;
  final bId = b.floor?.id;
  if (aId == null) return bId == null ? 0 : 1;
  if (bId == null) return -1;
  return aId.compareTo(bId);
}
