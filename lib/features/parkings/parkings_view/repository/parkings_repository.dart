import "dart:async";
import "dart:collection";

import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../../../utils/ref_extensions.dart";
import "../api_client/iparking_client.dart";
import "../models/parking.dart";

import "local_fav_parking_repository.dart";

part "parkings_repository.g.dart";

@riverpod
Future<IList<Parking>> parkingsRepository(Ref ref) async {
  final restClient = ref.watch(restClientProvider);
  ref.setRefresh(ParkingsConfig.parkingsRefreshInterval);
  final parkingList = await restClient.fetchParkings();
  return _sortParkingsByFav(parkingList, ref).toIList();
}

DoubleLinkedQueue<Parking> _sortParkingsByFav(Iterable<Parking> list, Ref ref) {
  final finalParkings = DoubleLinkedQueue<Parking>();
  for (final parking in list) {
    final isFavorite = ref.watch(localFavParkingsRepositoryProvider(parking.id)) ?? false;
    if (isFavorite) {
      finalParkings.addFirst(parking);
    } else {
      finalParkings.add(parking);
    }
  }
  return finalParkings;
}

extension DioFetchParkingsX on Dio {
  Future<List<Parking>> fetchParkings() async {
    final url = Env.parkingApiUrl;
    final response = await get<Map<String, dynamic>>(url);
    return _mapResponseToParkings(response.data);
  }

  List<Parking> _mapResponseToParkings(Map<String, dynamic>? data) {
    final places = data?["places"] as List<dynamic>? ?? [];
    return places.whereType<Map<String, dynamic>>().map(Parking.fromJson).toList();
  }
}
