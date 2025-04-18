import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../../../utils/type_converter.dart";

part "surrounding_response.freezed.dart";
part "surrounding_response.g.dart";
part "surrounding_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class SurroundingResponse with _$SurroundingResponse, _$SurroundingResponseTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SurroundingResponse({
    required int id,
    @translatableField required SurroundingResponseTranslations translations,
    required String areNoBarriers,
    required String areLoweredCurbs,
    required String isPavementRough,
    required String areParkingSpaces,
    required String areParkingSpacesForPwd,
    required String areHighCurbsAtParkingSpaceForPwd,
    required String isPathToAccessibleEntranceMarked,
    required String areDangerousElements,
    required String isLit,
    required String isNoisyStreetNearBuilding,
    required String isSidewalkSeparatedFromTheRoad,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForCognitiveDifficulties,
    required int building,
    required List<int> images,
  }) = _SurroundingResponse;

  const SurroundingResponse._();

  factory SurroundingResponse.fromJson(Map<String, dynamic> json) => _$SurroundingResponseFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class SurroundingResponseTranslations with _$SurroundingResponseTranslations {
  const factory SurroundingResponseTranslations({
    @JsonKey(name: "pl") required SurroundingResponseTranslationsDetails plTranslation,
  }) = _SurroundingResponseTranslations;

  factory SurroundingResponseTranslations.fromJson(Map<String, dynamic> json) =>
      _$SurroundingResponseTranslationsFromJson(json);
}

@freezed
abstract class SurroundingResponseTranslationsDetails with _$SurroundingResponseTranslationsDetails {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SurroundingResponseTranslationsDetails({
    required String areNoBarriersComment,
    required String areLoweredCurbsComment,
    required String isPavementRoughComment,
    required String areParkingSpacesComment,
    required String areParkingSpacesForPwdComment,
    required String areHighCurbsAtParkingSpaceForPwdComment,
    required String closestBuildings,
    required String isPathToAccessibleEntranceMarkedComment,
    required String areDangerousElementsComment,
    required String isLitComment,
    required String isNoisyStreetNearBuildingComment,
    required String isSidewalkSeparatedFromTheRoadComment,
    required String accessibilityLevelForMotorDisabilityComment,
    required String accessibilityLevelForBlindComment,
    required String accessibilityLevelForVisuallyImpairedComment,
    required String accessibilityLevelForHardOfHearingComment,
    required String accessibilityLevelForHighSensorySensitivityComment,
    required String accessibilityLevelForCognitiveDifficultiesComment,
    required String comment,
  }) = _SurroundingResponseTranslationsDetails;

  factory SurroundingResponseTranslationsDetails.fromJson(Map<String, dynamic> json) =>
      _$SurroundingResponseTranslationsDetailsFromJson(json);
}
