import "package:freezed_annotation/freezed_annotation.dart";

part "parking.freezed.dart";
part "parking.g.dart";

@freezed
class Parking with _$Parking {
  const factory Parking({
    required ParkingTranslations translations,
  }) = _Parking;

  factory Parking.fromJson(Map<String, dynamic> json) =>
      _$ParkingFromJson(json);
}

@freezed
class ParkingTranslations with _$ParkingTranslations {
  const factory ParkingTranslations({
    @JsonKey(name: "pl") required ParkingTranslation plTranslation,
  }) = _ParkingTranslations;

  factory ParkingTranslations.fromJson(Map<String, dynamic> json) =>
      _$ParkingTranslationsFromJson(json);
}

@freezed
class ParkingTranslation with _$ParkingTranslation {
  const factory ParkingTranslation({
    @JsonKey(name: "entry_location") required String entryLocation,
  }) = _ParkingTranslation;

  factory ParkingTranslation.fromJson(Map<String, dynamic> json) =>
      _$ParkingTranslationFromJson(json);
}
