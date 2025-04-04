import "dart:async";
import "dart:collection";

import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/gql_client_provider.dart";
import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../../../services/pick_parking_api_service/getUseParkingApiWrapper.graphql.dart";
import "../../../../utils/ref_extensions.dart";
import "../api_client/iparking_client.dart";
import "../api_client/iparking_commands.dart";
import "../models/parking.dart";
import "local_fav_parking_repository.dart";

part "parkings_repository.g.dart";

@riverpod
Future<IList<Parking>> parkingsRepository(Ref ref) async {
  final graphqlClient = await ref.watch(grapqlClientProvider.future);
  final parkingConfigResp = await graphqlClient.query$GetUseParkingApiWrapper();
  final useParkingApiWrapper = parkingConfigResp.parsedData?.CacheReferenceNumber?.useParkingApiWrapper ?? false;
  final restClient = ref.watch(restClientProvider);

  if (!useParkingApiWrapper) {
    ref.setRefresh(ParkingsConfig.parkingsRefreshInterval);
    final classicUrl = parkingConfigResp.parsedData?.CacheReferenceNumber?.classicParkingGetParks;
    Response<Map<String, dynamic>> response;
    if (classicUrl == null) {
      response = await ref.postIParkingCommand<Map<String, dynamic>>(FetchPlacesCommand(DateTime.now()));
    } else {
      response = await restClient.get(classicUrl);
    }

    final parkings = response.data?["places"] as List<dynamic>;
    final list =
        parkings
            .whereType<Map<String, dynamic>>()
            .map(
              classicUrl == null
                  ? Parking.fromJson
                  : (json) => Parking.fromJsonWithOverridenPhotoPrefix(
                    json,
                    parkingConfigResp.parsedData?.CacheReferenceNumber?.parkingPhotoPrefix ?? "",
                  ),
            )
            .toList();
    return _sortParkingsByFav(list, ref).toIList();
  }

  final javaUrl = parkingConfigResp.parsedData?.CacheReferenceNumber?.javaWrapperURL ?? Env.parkingApiUrl;

  final parkings = await restClient.get<List<dynamic>>("$javaUrl/");
  final List<Parking> parkingList =
      parkings.data?.whereType<Map<String, dynamic>>().map(Parking.fromJsonApiWrapper).toList() ?? [];
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
