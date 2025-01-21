import "package:freezed_annotation/freezed_annotation.dart";

part "surrounding_response.freezed.dart";
part "surrounding_response.g.dart";

@freezed
class SurroundingResponse with _$SurroundingResponse {
  const factory SurroundingResponse({
    required int id,
    required SurroundingResponseTranslations translations,
    @JsonKey(
      name: "are_no_barriers",
      fromJson: _stringToBool,
    )
    required bool areNoBarriers,
    @JsonKey(
      name: "are_lowered_curbs",
      fromJson: _stringToBool,
    )
    required bool areLoweredCurbs,
    @JsonKey(
      name: "is_pavement_rough",
      fromJson: _stringToBool,
    )
    required bool isPavementRough,
    @JsonKey(
      name: "are_parking_spaces",
      fromJson: _stringToBool,
    )
    required bool areParkingSpaces,
    @JsonKey(
      name: "are_parking_spaces_for_pwd",
      fromJson: _stringToBool,
    )
    required bool areParkingSpacesForPwd,
    @JsonKey(
      name: "are_high_curbs_at_parking_space_for_pwd",
      fromJson: _stringToBool,
    )
    required bool areHighCurbsAtParkingSpaceForPwd,
    @JsonKey(
      name: "is_path_to_accessible_entrance_marked",
      fromJson: _stringToBool,
    )
    required bool isPathToAccessibleEntranceMarked,
    @JsonKey(
      name: "are_dangerous_elements",
      fromJson: _stringToBool,
    )
    required bool areDangerousElements,
    @JsonKey(
      name: "is_lit",
      fromJson: _stringToBool,
    )
    required bool isLit,
    @JsonKey(
      name: "is_noisy_street_near_building",
      fromJson: _stringToBool,
    )
    required bool isNoisyStreetNearBuilding,
    @JsonKey(
      name: "is_sidewalk_separated_from_the_road",
      fromJson: _stringToBool,
    )
    required bool isSidewalkSeparatedFromTheRoad,
    @JsonKey(
      name: "accessibility_level_for_motor_disability",
      fromJson: _stringToInt,
    )
    required int accessibilityLevelForMotorDisability,
    @JsonKey(
      name: "accessibility_level_for_blind",
      fromJson: _stringToInt,
    )
    required int accessibilityLevelForBlind,
    @JsonKey(
      name: "accessibility_level_for_visually_impaired",
      fromJson: _stringToInt,
    )
    required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(
      name: "accessibility_level_for_hard_of_hearing",
      fromJson: _stringToInt,
    )
    required int accessibilityLevelForHardOfHearing,
    @JsonKey(
      name: "accessibility_level_for_high_sensory_sensitivity",
      fromJson: _stringToInt,
    )
    required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(
      name: "accessibility_level_for_cognitive_difficulties",
      fromJson: _stringToInt,
    )
    required int accessibilityLevelForCognitiveDifficulties,
    required int building,
    required List<int> images,
  }) = _SurroundingResponse;

  factory SurroundingResponse.fromJson(Map<String, dynamic> json) =>
      _$SurroundingResponseFromJson(json);
}

@freezed
class SurroundingResponseTranslations with _$SurroundingResponseTranslations {
  const factory SurroundingResponseTranslations({
    @JsonKey(name: "pl")
    required SurroundingResponseTranslationsDetails plTranslation,
  }) = _SurroundingResponseTranslations;

  factory SurroundingResponseTranslations.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SurroundingResponseTranslationsFromJson(json);
}

@freezed
class SurroundingResponseTranslationsDetails
    with _$SurroundingResponseTranslationsDetails {
  const factory SurroundingResponseTranslationsDetails({
    @JsonKey(name: "are_no_barriers_comment")
    required String areNoBarriersComment,
    @JsonKey(name: "are_lowered_curbs_comment")
    required String areLoweredCurbsComment,
    @JsonKey(name: "is_pavement_rough_comment")
    required String isPavementRoughComment,
    @JsonKey(name: "are_parking_spaces_comment")
    required String areParkingSpacesComment,
    @JsonKey(name: "are_parking_spaces_for_pwd_comment")
    required String areParkingSpacesForPwdComment,
    @JsonKey(name: "are_high_curbs_at_parking_space_for_pwd_comment")
    required String areHighCurbsAtParkingSpaceForPwdComment,
    @JsonKey(name: "closest_buildings") required String closestBuildings,
    @JsonKey(name: "is_path_to_accessible_entrance_marked_comment")
    required String isPathToAccessibleEntranceMarkedComment,
    @JsonKey(name: "are_dangerous_elements_comment")
    required String areDangerousElementsComment,
    @JsonKey(name: "is_lit_comment") required String isLitComment,
    @JsonKey(name: "is_noisy_street_near_building_comment")
    required String isNoisyStreetNearBuildingComment,
    @JsonKey(name: "is_sidewalk_separated_from_the_road_comment")
    required String isSidewalkSeparatedFromTheRoadComment,
    @JsonKey(name: "accessibility_level_for_motor_disability_comment")
    required String accessibilityLevelForMotorDisabilityComment,
    @JsonKey(name: "accessibility_level_for_blind_comment")
    required String accessibilityLevelForBlindComment,
    @JsonKey(name: "accessibility_level_for_visually_impaired_comment")
    required String accessibilityLevelForVisuallyImpairedComment,
    @JsonKey(name: "accessibility_level_for_hard_of_hearing_comment")
    required String accessibilityLevelForHardOfHearingComment,
    @JsonKey(name: "accessibility_level_for_high_sensory_sensitivity_comment")
    required String accessibilityLevelForHighSensorySensitivityComment,
    @JsonKey(name: "accessibility_level_for_cognitive_difficulties_comment")
    required String accessibilityLevelForCognitiveDifficultiesComment,
    required String comment,
  }) = _SurroundingResponseTranslationsDetails;

  factory SurroundingResponseTranslationsDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SurroundingResponseTranslationsDetailsFromJson(json);
}

bool _stringToBool(String value) {
  return value.toLowerCase() == "true";
}

int _stringToInt(String value) {
  return int.parse(value);
}
