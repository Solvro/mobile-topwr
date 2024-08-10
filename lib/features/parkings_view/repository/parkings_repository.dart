import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api_client/iparking_client.dart";
import "../api_client/iparking_commands.dart";
import "../models/parking.dart";

part "parkings_repository.g.dart";

extension RefIntervalRefreshX on Ref {
  void setRefresh(Duration interval) {
    final timer = Timer.periodic(
      interval,
      (t) => invalidate(parkingsRepositoryProvider),
    );
    onDispose(timer.cancel);
  }
}

@riverpod
Stream<List<Parking>?> parkingsRepository(ParkingsRepositoryRef ref) async* {
  ref.setRefresh(ParkingsConfig.parkingsRefreshInterval);
  final response = await ref.postIParkingCommand<Map<String, dynamic>>(
    FetchPlacesCommand(DateTime.now()),
  );
  final list = response.data?["places"] as List<dynamic>;
  yield list.whereType<Map<String, dynamic>>().map(Parking.fromJson).toList();
}
