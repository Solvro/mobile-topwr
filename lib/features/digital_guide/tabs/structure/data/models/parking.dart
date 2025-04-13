import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "parking.freezed.dart";
part "parking.g.dart";
part "parking.translatable.g.dart";

@freezed
@translatable
abstract class Parking with _$Parking, _$ParkingTranslatable {
  const factory Parking({required ParkingTranslations translations}) = _Parking;

  const Parking._();

  factory Parking.fromJson(Map<String, dynamic> json) => _$ParkingFromJson(json);
}

@freezed
abstract class ParkingTranslations with _$ParkingTranslations {
  const factory ParkingTranslations({@JsonKey(name: "pl") required ParkingTranslation plTranslation}) =
      _ParkingTranslations;

  factory ParkingTranslations.fromJson(Map<String, dynamic> json) => _$ParkingTranslationsFromJson(json);
}

@freezed
abstract class ParkingTranslation with _$ParkingTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ParkingTranslation({required String entryLocation}) = _ParkingTranslation;

  factory ParkingTranslation.fromJson(Map<String, dynamic> json) => _$ParkingTranslationFromJson(json);
}
