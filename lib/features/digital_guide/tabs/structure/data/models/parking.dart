import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "parking.freezed.dart";
part "parking.g.dart";
part "parking.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideParking with _$DigitalGuideParking, _$DigitalGuideParkingTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideParking({
    @translatableField required DigitalGuideParkingTranslations translations,
    required int id,
    required int orderNumber,
    required String isEntryFromGroundLevel,
    required String isSetMaximumVehicleHeight,
    required String permissionsTypes,
    required String areSpacesForPwd,
    required String areSpacesForPwdVerticalMarked,
    required String isRoadAccessibleForPeopleInWheelchairs,
    required double shortestLengthToNearestSpacesForPwd,
    required String isMultistoreyParking,
    required int building,
  }) = _DigitalGuideParking;

  const DigitalGuideParking._();

  factory DigitalGuideParking.fromJson(Map<String, dynamic> json) => _$DigitalGuideParkingFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class DigitalGuideParkingTranslations with _$DigitalGuideParkingTranslations {
  const factory DigitalGuideParkingTranslations({
    @JsonKey(name: "pl") required DigitalGuideParkingTranslation plTranslation,
  }) = _DigitalGuideParkingTranslations;

  factory DigitalGuideParkingTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideParkingTranslationsFromJson(json);
}

@freezed
abstract class DigitalGuideParkingTranslation with _$DigitalGuideParkingTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideParkingTranslation({
    required String entryLocation,
    required String isEntryFromGroundLevelComment,
    required String isSetMaximumVehicleHeightComment,
    required String areSpacesForPwdComment,
    required String areSpacesForPwdVerticalMarkedComment,
    required String isRoadAccessibleForPeopleInWheelchairsComment,
    required String isMultistoreyParkingComment,
    required String comment,
  }) = _DigitalGuideParkingTranslation;

  factory DigitalGuideParkingTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideParkingTranslationFromJson(json);
}
