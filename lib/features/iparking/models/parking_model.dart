// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../../map_view/controllers/controllers_set.dart";
import "../api_client/iparking_client.dart";

part "parking_model.freezed.dart";
part "parking_model.g.dart";

@freezed
class ParkingPlace with _$ParkingPlace implements GoogleNavigable {

  @Implements<GoogleNavigable>()
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ParkingPlace({
    required String id,
    required String parkingId,
    @JsonKey(name: "czas_pomiaru") required String measurementTime,
    @JsonKey(name: "liczba_miejsc") required String numberOfPlaces,
    required String symbol,
    required String? type,
    @JsonKey(name: "nazwa") required String name,
    required String? openHour,
    required String? closeHour,
    required String places,
    required String geoLan,
    required String geoLat,
    required String photo,
    @JsonKey(name: "aktywny") required String active,
    required String showPark,
    required String lp,
    required String address,
    required String trend,
  }) = _ParkingPlace;
  const ParkingPlace._();

  factory ParkingPlace.fromJson(Map<String, dynamic> json) =>
      _$ParkingPlaceFromJson(json);

  String get iParkPhotoUrl {
    return IParkingConfig.rootUrl + photo.trim();
  }

  double get latitude => double.tryParse(geoLat) ?? 0;
  double get longitude => double.tryParse(geoLan) ?? 0;

  @override
  LatLng get location => LatLng(latitude, longitude);

  String get addresFormatted =>
      address.replaceFirst(",", "\n").replaceAll("\n ", "\n");

  static const parkingPrefx = "Parking";
  String get nameNormalized =>
      name.startsWith(parkingPrefx) ? name : "$parkingPrefx $name";

  String get openingHours =>
      "${openHour?.formatIParkingDate ?? "06:00"} - ${closeHour?.formatIParkingDate ?? "22:00"}";

  String get counterText => "$numberOfPlaces ${trend.dashForm}";
}

extension _FormatIParkingDate on String {
  String get formatIParkingDate {
    return substring(0, length - 3);
  }
}

extension TrendDash on String {
  String get dashForm {
    switch (this) {
      case "0":
        return "-";
      case "1":
        return "/";
      case "-1":
        return r"\";
      default:
        return "?";
    }
  }
}
