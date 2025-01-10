import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../config/env.dart";

part "localization_repository.g.dart";

@riverpod
Future<Map<String, String>?> getBuildingDetails(Ref ref, int buildingId) async {
  try {
    final buildingUrl = "${Env.digitalGuideUrl}/buildings/$buildingId";
    final dio = ref.read(restClientProvider);
    dio.options.headers["Authorization"] =
        "Token ${Env.digitalGuideAuthorizationToken}";

    final buildingResponse = await dio.get(buildingUrl);

    if (buildingResponse.data is! Map<String, dynamic>) {
      debugPrint("Invalid response from /buildings/$buildingId");
      return null;
    }

    final Map<String, dynamic> buildingData =
        buildingResponse.data as Map<String, dynamic>;

    final Map<String, dynamic>? translations =
        buildingData["translations"] as Map<String, dynamic>?;
    if (translations == null || translations["pl"] == null) {
      debugPrint("translations or 'pl' key missing in /buildings/$buildingId");
      return null;
    }

    final Map<String, dynamic>? plTranslations =
        translations["pl"] as Map<String, dynamic>?;
    if (plTranslations == null) {
      debugPrint("'pl' translations are null for /buildings/$buildingId");
      return null;
    }

    final String? buildingName = plTranslations["name"] as String?;
    final String? buildingAddress = plTranslations["address"] as String?;

    if (buildingName == null || buildingAddress == null) {
      debugPrint("Building name or address is missing in translations['pl']");
      return null;
    }

    return {
      "name": buildingName,
      "address": buildingAddress,
    };
  } on Exception catch (e) {
    debugPrint("Error in getBuildingDetails: $e");
    return null;
  }
}

@riverpod
Future<String?> getImageUrlFromBuilding(Ref ref, int buildingId) async {
  try {
    final buildingUrl = "${Env.digitalGuideUrl}/buildings/$buildingId";
    final dio = ref.read(restClientProvider);
    dio.options.headers["Authorization"] =
        "Token ${Env.digitalGuideAuthorizationToken}";

    final buildingResponse = await dio.get(buildingUrl);

    if (buildingResponse.data is! Map<String, dynamic>) {
      debugPrint("Invalid response from /buildings/$buildingId");
      return null;
    }

    final Map<String, dynamic> buildingData =
        buildingResponse.data as Map<String, dynamic>;

    if (buildingData["location_map"] == null) {
      debugPrint(
        "location_map is null in the response from /buildings/$buildingId",
      );
      return null;
    }

    final int? locationMapId = buildingData["location_map"] as int?;
    if (locationMapId == null) {
      debugPrint(
        "location_map ID is null in the response from /buildings/$buildingId",
      );
      return null;
    }
    final imageUrl = await getImageUrl(ref, locationMapId);

    if (imageUrl == null) {
      debugPrint("Image URL not found for location_map ID: $locationMapId");
    }

    return imageUrl;
  } on Exception catch (e) {
    debugPrint("Error in getImageUrlFromBuilding: $e");
    return null;
  }
}

@riverpod
Future<String?> getImageUrl(Ref ref, int id) async {
  try {
    final imageUrl = "${Env.digitalGuideUrl}/images/$id";
    final dio = ref.read(restClientProvider);
    dio.options.headers["Authorization"] =
        "Token ${Env.digitalGuideAuthorizationToken}";

    final imageResponse = await dio.get(imageUrl);

    if (imageResponse.data is! Map<String, dynamic>) {
      debugPrint("Invalid response from /images/$id");
      return null;
    }
    final Map<String, dynamic> imageData =
        imageResponse.data as Map<String, dynamic>;

    if (imageData["image_960w"] == null) {
      debugPrint("Invalid response from /images/$id");
      return null;
    }

    final String image = imageData["image_960w"] as String;
    return image;
  } on Exception catch (e) {
    debugPrint("Error in getImageUrl: $e");
    return null;
  }
}
