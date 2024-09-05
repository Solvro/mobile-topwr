import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api_client/iparking_client.dart";
import "../api_client/iparking_commands.dart";
import "../models/parking.dart";
import "local_fav_parking_repository.dart";

part "parkings_repository.g.dart";

extension RefIntervalRefreshX on Ref {
  void setRefresh(Duration interval) {
    final timer = Timer.periodic(
      interval,
      (t) => invalidateSelf(),
    );
    onDispose(timer.cancel);
  }
}

@riverpod
Future<IList<Parking>> parkingsRepository(ParkingsRepositoryRef ref) async {
  ref.setRefresh(ParkingsConfig.parkingsRefreshInterval);
  final response = await ref.postIParkingCommand<Map<String, dynamic>>(
    FetchPlacesCommand(DateTime.now()),
  );
  final parkings = response.data?["places"] as List<dynamic>;
  final List<Parking> list =
      parkings.whereType<Map<String, dynamic>>().map(Parking.fromJson).toList();

  return _sortParkingsByFav(list, ref).toIList();
}

List<Parking> _sortParkingsByFav(
    List<Parking> list, ParkingsRepositoryRef ref,) {
  final List<Parking> finalParkings = [];
  for (final parking in list) {
    final isFavorite =
        ref.watch(localFavParkingsRepositoryProvider(parking.id)) ?? false;
    if (isFavorite) {
      finalParkings.insert(0, parking);
    } else {
      finalParkings.add(parking);
    }
  }
  return finalParkings;
}
