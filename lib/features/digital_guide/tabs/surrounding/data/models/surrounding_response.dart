import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

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
    required SurroundingResponseTranslations translations,
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
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForCognitiveDifficulties,
    required int building,
    required List<int> images,
  }) = _SurroundingResponse;

  const SurroundingResponse._();

  factory SurroundingResponse.fromJson(Map<String, dynamic> json) => _$SurroundingResponseFromJson(json);
}

@freezed
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
