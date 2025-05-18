import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../api_base_rest/shared_models/image_data.dart";

part "building_data.freezed.dart";
part "building_data.g.dart";

@freezed
abstract class BuildingDataResponse with _$BuildingDataResponse {
  const factory BuildingDataResponse({required IList<BuildingData> data}) = _BuildingDataResponse;
  factory BuildingDataResponse.fromJson(Map<String, dynamic> json) => _$BuildingDataResponseFromJson(json);
}

@freezed
abstract class BuildingData with _$BuildingData {
  const factory BuildingData({
    required int id,
    required String identifier,
    @JsonKey(name: "specialName") required String? naturalName,
    required String addressLine1,
    required String addressLine2,
    required double latitude,
    required double longitude,
    required String? externalDigitalGuideMode,
    required String? externalDigitalGuideIdOrUrl,
    required ImageData? cover,
  }) = _BuildingData;

  factory BuildingData.fromJson(Map<String, dynamic> json) => _$BuildingDataFromJson(json);
}
