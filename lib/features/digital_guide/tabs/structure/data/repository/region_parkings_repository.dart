import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/parking.dart";

part "region_parkings_repository.g.dart";

@riverpod
Future<IList<Parking>> regionParkingsRepository(
  Ref ref,
  List<int> parkingsIDs,
) async {
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
