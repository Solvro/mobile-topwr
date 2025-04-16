import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../utils/type_converter.dart";

part "region.freezed.dart";
part "region.g.dart";
part "region.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Region with _$Region, _$RegionTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Region({
    @translatable required RegionTranslations translations,
    required List<int> dressingRooms,
    required List<int> lodges,
    required List<int> informationPoints,
    required List<int> toilets,
    required List<int> adaptedToilets,
    required List<int> lifts,
    required List<int> stairs,
    required List<int> ramps,
    required List<int> corridors,
    required List<int> stairways,
    required List<int> rooms,
    required List<int> parkings,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForCognitiveDifficulties,
  }) = _Region;

  const Region._();

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class RegionTranslations with _$RegionTranslations {
  const factory RegionTranslations({@JsonKey(name: "pl") required RegionTranslation plTranslation}) =
      _RegionTranslations;

  factory RegionTranslations.fromJson(Map<String, dynamic> json) => _$RegionTranslationsFromJson(json);
}

@freezed
abstract class RegionTranslation with _$RegionTranslation {
  const factory RegionTranslation({required String name, required String location}) = _RegionTranslation;

  factory RegionTranslation.fromJson(Map<String, dynamic> json) => _$RegionTranslationFromJson(json);
}
