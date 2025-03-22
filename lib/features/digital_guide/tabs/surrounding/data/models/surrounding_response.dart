import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../utils/type_converter.dart";

part "surrounding_response.freezed.dart";
part "surrounding_response.g.dart";

@freezed
abstract class SurroundingResponse with _$SurroundingResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SurroundingResponse({
    required int id,
    required SurroundingResponseTranslations translations,
    @JsonKey(fromJson: stringToBool) required bool areNoBarriers,
    @JsonKey(fromJson: stringToBool) required bool areLoweredCurbs,
    @JsonKey(fromJson: stringToBool) required bool isPavementRough,
    @JsonKey(fromJson: stringToBool) required bool areParkingSpaces,
    @JsonKey(fromJson: stringToBool) required bool areParkingSpacesForPwd,
    @JsonKey(fromJson: stringToBool) required bool areHighCurbsAtParkingSpaceForPwd,
    @JsonKey(fromJson: stringToBool) required bool isPathToAccessibleEntranceMarked,
    @JsonKey(fromJson: stringToBool) required bool areDangerousElements,
    @JsonKey(fromJson: stringToBool) required bool isLit,
    @JsonKey(fromJson: stringToBool) required bool isNoisyStreetNearBuilding,
    @JsonKey(fromJson: stringToBool) required bool isSidewalkSeparatedFromTheRoad,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: stringToInt) required int accessibilityLevelForCognitiveDifficulties,
    required int building,
    required List<int> images,
  }) = _SurroundingResponse;

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
