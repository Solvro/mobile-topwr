import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../config/env.dart";

part "localization_repository.g.dart";

@riverpod
Future<String?> getImageUrlFromBuilding(Ref ref, int buildingId) async {
  try {
    // Pobierz dane z endpointu /buildings/{buildingId}
    final buildingUrl = "${Env.digitalGuideUrl}/buildings/$buildingId";
    final dio = ref.read(restClientProvider);
    dio.options.headers["Authorization"] =
    "Token ${Env.digitalGuideAuthorizationToken}";

    final buildingResponse = await dio.get(buildingUrl);

    // Sprawdź, czy odpowiedź zawiera "location_map"
    if (buildingResponse.data is! Map<String, dynamic> ||
        buildingResponse.data["location_map"] == null) {
      debugPrint("Invalid response from /buildings/$buildingId");
      return null;
    }

    // Pobierz wartość pola "location_map"
    final int? locationMapId = buildingResponse.data["location_map"] as int?;

    if (locationMapId == null) {
      debugPrint("location_map is null in the response from /buildings/$buildingId");
      return null;
    }

    // Użyj ID z "location_map" do pobrania obrazka z /images/{id}
    final imageUrl = await getImageUrl(ref, locationMapId);

    if (imageUrl == null) {
      debugPrint("Image URL not found for location_map ID: $locationMapId");
    }

    return imageUrl;
  } catch (e) {
    debugPrint("Error in getImageUrlFromBuilding: $e");
    return null;
  }
}

@riverpod
Future<String?> getImageUrl(Ref ref, int id) async {
  try {
    // Pobierz dane z endpointu /images/{id}
    final imageUrl = "${Env.digitalGuideUrl}/images/$id";
    final dio = ref.read(restClientProvider);
    dio.options.headers["Authorization"] =
    "Token ${Env.digitalGuideAuthorizationToken}";

    final imageResponse = await dio.get(imageUrl);

    // Sprawdź, czy odpowiedź zawiera klucz "image_960w"
    if (imageResponse.data is! Map<String, dynamic> ||
        imageResponse.data["image_960w"] == null) {
      debugPrint("Invalid response from /images/$id");
      return null;
    }

    final String image = imageResponse.data["image_960w"] as String;
    return image;
  } catch (e) {
    debugPrint("Error in getImageUrl: $e");
    return null;
  }
}