import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "region.freezed.dart";
part "region.g.dart";
part "region.translatable.dart";

@freezed
@translatable
abstract class Region with _$Region, _$RegionTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Region({
    required RegionTranslations translations,
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
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForCognitiveDifficulties,
  }) = _Region;

  const Region._();

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}

@freezed
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

int _stringToInt(String value) {
  return int.tryParse(value) ?? 1;
}
