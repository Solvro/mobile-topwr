import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api_client/iparking_client.dart";
import "../api_client/iparking_commands.dart";
import "../models/parking_model.dart";

part "parkings_repo.g.dart";

extension RefIntervalRefresh on Ref {
  void setRefresh(Duration interval) {
    final timer = Timer.periodic(
      interval,
      (t) => invalidateSelf(),
    );
    onDispose(timer.cancel);
  }
}

@riverpod
Stream<List<ParkingPlace>?> parkingsRepo(ParkingsRepoRef ref) async* {
  ref.setRefresh(IParkingConfig.parkingsRefreshInterval);
  final response = await ref.postIParkingCommand<Map<String, dynamic>>(
    FetchPlacesCommand(DateTime.now()),
  );
  final list = response.data?["places"] as List<dynamic>;
  yield list
      .whereType<Map<String, dynamic>>()
      .map(ParkingPlace.fromJson)
      .toList();
}
