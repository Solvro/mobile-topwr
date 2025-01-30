import "dart:async";
import "dart:collection";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/gql_client_provider.dart";
import "../../../api_base_rest/client/dio_client.dart";
import "../../../config/env.dart";
import "../../../utils/ref_extensions.dart";
import "../api_client/iparking_client.dart";
import "../api_client/iparking_commands.dart";
import "../models/parking.dart";
import "../pick_correct_api_service/getUseParkingApiWrapper.graphql.dart";
import "local_fav_parking_repository.dart";

part "parkings_repository.g.dart";

@riverpod
Future<IList<Parking>> parkingsRepository(Ref ref) async {
  final graphqlClient = await ref.watch(grapqlClientProvider.future);
  final response = await graphqlClient.query$GetUseParkingApiWrapper();
  final useParkingApiWrapper = response.parsedData?.CacheReferenceNumber?.useParkingApiWrapper ?? false;

  if(!useParkingApiWrapper){
    ref.setRefresh(ParkingsConfig.parkingsRefreshInterval);
    final response = await ref.postIParkingCommand<Map<String, dynamic>>(
      FetchPlacesCommand(DateTime.now()),
    );
    final parkings = response.data?["places"] as List<dynamic>;
    final list = parkings.whereType<Map<String, dynamic>>().map(Parking.fromJson);
    return _sortParkingsByFav(list, ref).toIList();
  }

  //final restClient = ref.watch(restClientProvider);
  // final parkings = restClient.get(Env.parkingApiUrl) as List<dynamic>;
  final parkings = [
  {
    "parkingId": 4,
    "freeSpots": 33,
    "totalSpots": 97,
    "name": "best parking",
    "symbol": "WRO",
    "openingHours": "08:00:00",
    "closingHours": "22:00:00",
    "address": {
      "streetAddress": "Example 201, 11-041 Wrocław",
      "geoLatitude": 21.37,
      "geoLongitude": -4.2,
    },
  },];


  final List<Parking> parkingList = parkings
      .whereType<Map<String, dynamic>>() 
      .map(Parking.fromJsonApiWrapper) 
      .toList();
    return _sortParkingsByFav(parkingList, ref).toIList();
  
}

DoubleLinkedQueue<Parking> _sortParkingsByFav(
  Iterable<Parking> list,
  Ref ref,
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
