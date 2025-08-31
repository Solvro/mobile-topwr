import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../map_view/controllers/controllers_set.dart";
import "building.dart";

part "bicycle_shower.freezed.dart";
part "bicycle_shower.g.dart";

@freezed
abstract class BicycleShowerDataResponse with _$BicycleShowerDataResponse {
  const factory BicycleShowerDataResponse({required IList<BicycleShower> data}) = _BicycleShowerDataResponse;
  const BicycleShowerDataResponse._();
  factory BicycleShowerDataResponse.fromJson(Map<String, dynamic> json) => _$BicycleShowerDataResponseFromJson(json);
}

@freezed
abstract class BicycleShower with _$BicycleShower implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  const factory BicycleShower({
    @JsonKey(name: "id") required int rawId,
    required String? room,
    required String? instructions,
    required double latitude,
    required double longitude,
    ImageData? photo,
    Building? building,
  }) = _BicycleShower;

  const BicycleShower._();

  factory BicycleShower.fromJson(Map<String, dynamic> json) => _$BicycleShowerFromJson(json);

  @override
  String get id => rawId.toString();

  @override
  LatLng get location => LatLng(latitude, longitude);
}
