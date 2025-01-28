import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../data/models/region.dart";
import "../../rooms/data/models/digital_guide_room.dart";
import "../data/models/corridor.dart";
import "../data/models/dressing_room.dart";
import "../data/models/information_point.dart";
import "../data/models/lift.dart";
import "../data/models/lodge.dart";
import "../data/models/parking.dart";
import "../data/models/ramp.dart";
import "../data/models/stairs.dart";
import "../data/models/stairway.dart";
import "../data/models/toilet.dart";
import "../data/repository/corridors_repository.dart";
import "../data/repository/dressing_rooms_repository.dart";
import "../data/repository/information_points_repository.dart";
import "../data/repository/lifts_repository.dart";
import "../data/repository/lodges_repository.dart";
import "../data/repository/ramps_repository.dart";
import "../data/repository/region_parkings_repository.dart";
import "../data/repository/region_rooms_repository.dart";
import "../data/repository/stairs_repository.dart";
import "../data/repository/stairways_repository.dart";
import "../data/repository/toilets_repository.dart";

part "digital_guide_region_use_cases.g.dart";

typedef RegionData = ({
  IList<Corridor> corridors,
  IList<Stairs> stairs,
  IList<Ramp> ramps,
  IList<Stairway> stairways,
  IList<Lift> lifts,
  IList<Lodge> lodges,
  IList<InformationPoint> informationPoints,
  IList<DressingRoom> dressingRooms,
  IList<Toilet> toilets,
  IList<DigitalGuideRoom> rooms,
  IList<Parking> parkings,
});

@riverpod
Future<RegionData> digitalGuideRegionUrseCases(Ref ref, Region region) async {
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
