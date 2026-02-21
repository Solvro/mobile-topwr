import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../data/models/region.dart";
import "../../dressing_room/data/models/digital_guide_dressing_room.dart";
import "../../dressing_room/data/repository/dressing_rooms_repository.dart";
import "../../information_points/models/digital_guide_information_points.dart";
import "../../information_points/repository/information_point_repository.dart";
import "../../lifts/data/models/digital_guide_lift.dart";
import "../../lifts/data/repository/lifts_repository.dart";
import "../../lodge/data/models/digital_guide_lodge.dart";
import "../../lodge/data/repository/lodges_repository.dart";
import "../../rooms/data/models/digital_guide_room.dart";
import "../../rooms/data/repository/rooms_repository.dart";
import "../data/models/corridor.dart";
import "../data/models/parking.dart";
import "../data/models/ramp.dart";
import "../data/models/stairs.dart";
import "../data/models/stairway.dart";
import "../data/models/toilet.dart";
import "../data/repository/corridors_repository.dart";
import "../data/repository/ramps_repository.dart";
import "../data/repository/region_parkings_repository.dart";
import "../data/repository/stairs_repository.dart";
import "../data/repository/stairways_repository.dart";
import "../data/repository/toilets_repository.dart";

part "digital_guide_region_use_cases.g.dart";

typedef RegionData = ({
  IList<Corridor> corridors,
  IList<Stairs> stairs,
  IList<Ramp> ramps,
  IList<Stairway> stairways,
  IList<DigitalGuideLift> lifts,
  IList<DigitalGuideLodge> lodges,
  IList<DigitalGuideInformationPoint> informationPoints,
  IList<DigitalGuideDressingRoom> dressingRooms,
  IList<Toilet> toilets,
  IList<DigitalGuideRoom> rooms,
  IList<DigitalGuideParking> parkings,
});

@riverpod
Future<RegionData> digitalGuideRegionUseCases(Ref ref, Region region) async {
  final corridors = await ref.watch(corridorsRepositoryProvider(region.corridors).future);
  final stairs = await ref.watch(stairsListRepositoryProvider(region.stairs).future);
  final ramps = await ref.watch(rampsRepositoryProvider(region.ramps).future);
  final stairways = await ref.watch(stairwaysRepositoryProvider(region.stairways).future);
  final lifts = await ref.watch(liftsRepositoryProvider(region.lifts).future);
  final lodges = await ref.watch(lodgesFromIDsRepositoryProvider(region.lodges).future);
  final informationPoints = await ref.watch(informationPointsFromIDRepositoryProvider(region.informationPoints).future);
  final dressingRooms = await ref.watch(dressingRoomsFromIDsRepositoryProvider(region.dressingRooms).future);
  final toilets = await ref.watch(toiletsRepositoryProvider(region.toilets).future);
  final rooms = await ref.watch(roomsByIDsRepositoryProvider(region.rooms).future);
  final parkings = await ref.watch(regionParkingsRepositoryProvider(region.parkings).future);

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
