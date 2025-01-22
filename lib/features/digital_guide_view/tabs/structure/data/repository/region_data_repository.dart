import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../../data/models/region.dart";
import "../models/region_data.dart";
import "corridors_repository.dart";
import "dressing_rooms_repository.dart";
import "information_points_repository.dart";
import "lifts_repository.dart";
import "lodges_repository.dart";
import "ramps_repository.dart";
import "region_parkings_repository.dart";
import "region_rooms_repository.dart";
import "stairs_repository.dart";
import "stairways_repository.dart";
import "toilets_repository.dart";

part "region_data_repository.g.dart";

@riverpod
Future<RegionData> regionDataRepository(Ref ref, Region region) async {
  final corridors =
      await ref.watch(corridorsRepositoryProvider(region.corridors).future);
  final stairs =
      await ref.watch(stairsRepositoryProvider(region.stairs).future);
  final ramps = await ref.watch(rampsRepositoryProvider(region.ramps).future);
  final stairways =
      await ref.watch(stairwaysRepositoryProvider(region.stairways).future);
  final lifts = await ref.watch(liftsRepositoryProvider(region.lifts).future);
  final lodges =
      await ref.watch(lodgesRepositoryProvider(region.lodges).future);
  final informationPoints = await ref.watch(
    informationPointsRepositoryProvider(region.informationPoints).future,
  );
  final dressingRooms = await ref.watch(
    dressingRoomsRepositoryProvider(region.dressingRooms).future,
  );
  final toilets =
      await ref.watch(toiletsRepositoryProvider(region.toilets).future);
  final rooms =
      await ref.watch(regionRoomsRepositoryProvider(region.rooms).future);
  final parkings =
      await ref.watch(regionParkingsRepositoryProvider(region.parkings).future);

  return (
    corridors: corridors,
    stairs: stairs,
    ramps: ramps,
    stairways: stairways,
    lifts: lifts,
    lodges: lodges,
    informationPoints: informationPoints,
    dressingRooms: dressingRooms,
    toilets: toilets,
    rooms: rooms,
    parkings: parkings,
  );
}
