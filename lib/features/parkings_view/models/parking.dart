import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../map_view/controllers/controllers_set.dart";
import "../api_client/iparking_client.dart";

part "parking.freezed.dart";
part "parking.g.dart";

@freezed
class Parking with _$Parking implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Parking({
    required String id,
    required String parkingId,
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
  const Parking._();

  factory Parking.fromJson(Map<String, dynamic> json) =>
      _$ParkingFromJson(json);

  factory Parking.fromJsonApiWrapper(Map<String, dynamic> json) {
    final address = json["address"] as Map<String, dynamic>;
    
    return Parking(
      id: json["parkingId"].toString(),
      parkingId: json["parkingId"].toString(),
      numberOfPlaces: json["freeSpots"].toString(),
      symbol: json["symbol"] as String,
      type: null,
      name: json["name"] as String,
      openHour: json["openingHours"] as String?,
      closeHour: json["closingHours"] as String?,
      places: json["totalSpots"].toString(),
      geoLan: address["geoLongitude"].toString(),
      geoLat: address["geoLatitude"].toString(),
      photo: "",
      active: "1", 
      showPark: "1", 
      lp: "1",
      address: address["streetAddress"] as String,
      trend: json["trend"] as String,
    );
  }

  String get iParkPhotoUrl {
    return ParkingsConfig.rootUrl + photo.trim();
  }

  String get parsedNumberOfPlaces =>
      numberOfPlaces.startsWith("-") ? "0" : numberOfPlaces;

  double get latitude => double.tryParse(geoLat) ?? 0;
  double get longitude => double.tryParse(geoLan) ?? 0;

  @override
  LatLng get location => LatLng(latitude, longitude);

  String get addressFormatted =>
      address.replaceFirst(",", "\n").replaceAll("\n ", "\n");

  static const parkingPrefix = "Parking";
  String get nameNormalized =>
      name.startsWith(parkingPrefix) ? name : "$parkingPrefix $name";

  String get openingHours =>
      "${openHour?.formatIParkingDate ?? "06:00"} - ${closeHour?.formatIParkingDate ?? "22:00"}";
}

extension _FormatIParkingDateX on String {
  String get formatIParkingDate {
    return substring(0, length - 3);
  }
}

extension GetTrendArrowX on String {
  IconData get arrowIcon {
    switch (this) {
      case "0":
        return Icons.east;
      case "1":
        return Icons.north_east;
      case "-1":
        return Icons.south_east;
      default:
        return const IconData(0);
    }
  }
}
