import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_client/iparking_client.dart';
import '../api_client/iparking_commands.dart';
import '../models/parking_model.dart';

part "parkings_repo.g.dart";

@riverpod
Future<List<ParkingPlace>?> parkingsRepo(ParkingsRepoRef ref) async {
  final timer = Timer.periodic(
      IParkingConfig.parkingsRefreshInterval, (t) => ref.invalidateSelf());
  ref.onDispose(timer.cancel);

  final response = await ref.postIParkingCommand(
    FetchPlacesCommand(DateTime.now()),
  );
  final list = response.data["places"] as List<dynamic>;
  return list.map((e) => ParkingPlace.fromJson(e)).toList();
}
