import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../../../../data/models/region.dart";
import "../../../rooms/data/models/digital_guide_room.dart";
import "../models/corridor.dart";
import "../models/dressing_room.dart";
import "../models/information_point.dart";
import "../models/lift.dart";
import "../models/lodge.dart";
import "../models/parking.dart";
import "../models/ramp.dart";
import "../models/region_data.dart";
import "../models/stairs.dart";
import "../models/stairway.dart";
import "../models/toilet.dart";

part "region_data_repository.g.dart";

@riverpod
Future<RegionData> regionDataRepository(Ref ref, Region region) async {
  final corridors = await ref.watch(corridorsRepositoryProvider(region.corridorsIndices).future);
  final stairs = await ref.watch(stairsRepositoryProvider(region.stairsIndices).future);
  final ramps = await ref.watch(rampsRepositoryProvider(region.rampsIndices).future);
  final stairways = await ref.watch(stairwaysRepositoryProvider(region.stwairwaysIndices).future);
  final lifts = await ref.watch(liftsRepositoryProvider(region.liftsIndices).future);
  final lodges = await ref.watch(lodgesRepositoryProvider(region.lodgesIndices).future);
  final informationPoints = await ref.watch(informationPointsRepositoryProvider(region.informationPointsIndices).future);
  final dressingRooms = await ref.watch(dressingRoomsRepositoryProvider(region.dressingRoomIndices).future);
  final toilets = await ref.watch(toiletsRepositoryProvider(region.toiletsIndices).future);
  final rooms = await ref.watch(regionRoomsRepositoryProvider(region.roomsIds).future);
  final parkings = await ref.watch(regionParkingsRepositoryProvider(region.parkingsIndices).future);
;
  return RegionData(
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

@riverpod
Future<IList<Corridor>> corridorsRepository(Ref ref, List<int> corridorsIDs) async {
  Future<Corridor> getCorridor(int corridorID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "corridors/$corridorID",
      Corridor.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final corridors = await Future.wait(corridorsIDs.map(getCorridor));
  return corridors.lock;
}

@riverpod
Future<IList<Stairs>> stairsRepository(Ref ref, List<int> stairsIDs) async {
  Future<Stairs> getStairs(int stairsID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "stairs/$stairsID",
      Stairs.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final stairs = await Future.wait(stairsIDs.map(getStairs));
  return stairs.lock;
}

@riverpod
Future<IList<Ramp>> rampsRepository(Ref ref, List<int> rampsIDs) async {
  Future<Ramp> getRamp(int rampID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "ramps/$rampID",
      Ramp.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final ramps = await Future.wait(rampsIDs.map(getRamp));
  return ramps.lock;
}

@riverpod
Future<IList<Stairway>> stairwaysRepository(Ref ref, List<int> stairwaysIDs) async {
  Future<Stairway> getStairway(int stairwayID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "stairways/$stairwayID",
      Stairway.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final stairway = await Future.wait(stairwaysIDs.map(getStairway));
  return stairway.lock;
}

@riverpod
Future<IList<Lift>> liftsRepository(Ref ref, List<int> liftIDs) async {
  Future<Lift> getLift(int liftID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "lifts/$liftID",
      Lift.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final lifts = await Future.wait(liftIDs.map(getLift));
  return lifts.lock;
}

@riverpod
Future<IList<Lodge>> lodgesRepository(Ref ref, List<int> lodgesIDs) async {
  Future<Lodge> getLodge(int lodgeID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "lodges/$lodgeID",
      Lodge.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final lodges = await Future.wait(lodgesIDs.map(getLodge));
  return lodges.lock;
}

@riverpod
Future<IList<InformationPoint>> informationPointsRepository(Ref ref, List<int> informationPointsIDs) async {
  Future<InformationPoint> getInformationPoint(int informationPointID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "information_points/$informationPointID",
      InformationPoint.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final informationPoints = await Future.wait(informationPointsIDs.map(getInformationPoint));
  return informationPoints.lock;
}


@riverpod
Future<IList<DressingRoom>> dressingRoomsRepository(Ref ref, List<int> dressingRoomsIDs) async {
  Future<DressingRoom> getDressingRoom(int dressingRoomID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "dressing_rooms/$dressingRoomID",
      DressingRoom.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final dressingRooms = await Future.wait(dressingRoomsIDs.map(getDressingRoom));
  return dressingRooms.lock;
}

@riverpod
Future<IList<Toilet>> toiletsRepository(Ref ref, List<int> toiletsIDs) async {
  Future<Toilet> getToilet(int toiletID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "toilets/$toiletID",
      Toilet.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final toilets = await Future.wait(toiletsIDs.map(getToilet));
  return toilets.lock;
}

@riverpod
Future<IList<DigitalGuideRoom>> regionRoomsRepository(Ref ref, List<int> roomsIDs) async {
  Future<DigitalGuideRoom> getRoom(int roomID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "rooms/$roomID",
      DigitalGuideRoom.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final rooms = await Future.wait(roomsIDs.map(getRoom));
  return rooms.lock;
}

@riverpod
Future<IList<Parking>> regionParkingsRepository(Ref ref, List<int> parkingsIDs) async {
  Future<Parking> getParking(int parkingID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "parkings/$parkingID",
      Parking.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final parkings = await Future.wait(parkingsIDs.map(getParking));
  return parkings.lock;
}
