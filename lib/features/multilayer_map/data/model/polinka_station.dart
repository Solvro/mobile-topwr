import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../branches/data/model/branch.dart";
import "building.dart";

part "polinka_station.freezed.dart";
part "polinka_station.g.dart";

@freezed
abstract class PolinkaStationsDataResponse with _$PolinkaStationsDataResponse {
  const factory PolinkaStationsDataResponse({required IList<PolinkaStation> data}) = _PolinkaStationsDataResponse;
  const PolinkaStationsDataResponse._();

  factory PolinkaStationsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PolinkaStationsDataResponseFromJson(json);
}

@freezed
abstract class PolinkaStation with _$PolinkaStation {
  const factory PolinkaStation({
    @JsonKey(name: "id") required int id,
    required String name,
    required int campusId,
    required String addressLine1,
    required String? addressLine2,
    required double latitude,
    required double longitude,
    required Branch branch,
    required ExternalDigitalGuideMode? externalDigitalGuideMode,
    required String? externalDigitalGuideIdOrUrl,
    ImageData? photo,
  }) = _PolinkaStation;

  const PolinkaStation._();

  factory PolinkaStation.fromJson(Map<String, dynamic> json) => _$PolinkaStationFromJson(json);
}
