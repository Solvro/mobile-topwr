import "dart:async";
import "dart:collection";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/gql_client_provider.dart";
import "../../../utils/ref_extensions.dart";
import "../api_client/iparking_client.dart";
import "../api_client/iparking_commands.dart";
import "../models/parking.dart";
import "../pick_correct_api_service/getUseParkingApiWrapper.graphql.dart";
import "local_fav_parking_repository.dart";

part "parkings_repository.g.dart";

@riverpod
Future<IList<Parking>> parkingsRepository(Ref ref) async {
  final apiClient = await ref.watch(grapqlClientProvider.future);
  final response = await apiClient.query$GetUseParkingApiWrapper();
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

  return IList.empty();
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
