import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../map_view/controllers/controllers_set.dart";
import "building.dart";

part "aed.freezed.dart";
part "aed.g.dart";

@freezed
abstract class AedDataResponse with _$AedDataResponse {
  const factory AedDataResponse({required IList<Aed> data}) = _AedDataResponse;
  const AedDataResponse._();
  factory AedDataResponse.fromJson(Map<String, dynamic> json) => _$AedDataResponseFromJson(json);
}

@freezed
abstract class Aed with _$Aed implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  const factory Aed({
    @JsonKey(name: "id") required int rawId,
    required double latitude,
    required double longitude,
    required ImageData? photo,
    required String? addressLine1,
    required String? addressLine2,
    Building? building,
  }) = _Aed;

  const Aed._();

  factory Aed.fromJson(Map<String, dynamic> json) => _$AedFromJson(json);

  @override
  String get id => rawId.toString();

  @override
  LatLng get location => LatLng(latitude, longitude);

  String get title => "AED — ${building?.name}";
}
