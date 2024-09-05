import "dart:async";
import "dart:collection";

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
  final list = parkings.whereType<Map<String, dynamic>>().map(Parking.fromJson);

  return _sortParkingsByFav(list, ref).toIList();
}

DoubleLinkedQueue<Parking> _sortParkingsByFav(
  Iterable<Parking> list,
  ParkingsRepositoryRef ref,
) {
  final finalParkings = DoubleLinkedQueue<Parking>();
  for (final parking in list) {
    final isFavorite =
        ref.watch(localFavParkingsRepositoryProvider(parking.id)) ?? false;
    if (isFavorite) {
      finalParkings.addFirst(parking);
    } else {
      finalParkings.add(parking);
    }
  }
  return finalParkings;
}
