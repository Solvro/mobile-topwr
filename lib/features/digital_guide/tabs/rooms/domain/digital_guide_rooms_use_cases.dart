import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/digital_guide_response.dart";
import "../../../data/models/level.dart";
import "../../../data/repository/levels_repository.dart";
import "../data/models/digital_guide_room.dart";
import "../data/repository/rooms_repository.dart";

part "digital_guide_rooms_use_cases.g.dart";

typedef LevelWithRooms = ({
  Level level,
  IList<DigitalGuideRoom> rooms,
});

@riverpod
Future<IList<LevelWithRooms>> getLevelsWithRoomsUseCase(
  Ref ref,
  DigitalGuideResponse digitalGuideData,
) async {
  final levels = await ref
      .watch(levelsWithRegionsRepositoryProvider(digitalGuideData).future);

  final levelsWithRoomsData = await Future.wait(
    levels.map((level) async {
      final rooms =
          await ref.watch(roomsByLevelRepositoryProvider(level).future);
      return (level: level.level, rooms: rooms);
    }),
  );
  return levelsWithRoomsData
      .where(
        (levelsWithRooms) => levelsWithRooms.rooms.isNotEmpty,
      )
      .toIList();
}
