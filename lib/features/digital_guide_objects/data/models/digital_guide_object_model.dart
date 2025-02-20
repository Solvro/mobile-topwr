import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_object_model.freezed.dart";
part "digital_guide_object_model.g.dart";

bool _stringToBool(String? str) {
  return str?.toLowerCase() == "true";
}

@freezed
class DigitalGuideObjectModel with _$DigitalGuideObjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectModel({
    required int id,
    required DigitalGuideObjectTranslations translations,
    String? linkToObjectLocation,
    String? isPossibilityToEnterWithAssistanceDog,
    String? isMicronavigationSystem,
    String? areGuidancePaths,
    String? areInformationBoardsWithBrailleDescription,
    String? areInformationBoardsWithLargeFont,
    required String accessibilityLevelForMotorDisability,
    required String accessibilityLevelForBlind,
    required String accessibilityLevelForVisuallyImpaired,
    required String accessibilityLevelForHardOfHearing,
    required String accessibilityLevelForHighSensorySensitivity,
    required String accessibilityLevelForCognitiveDifficulties,
    String? locationMap,
    required List<int> images,
  }) = _DigitalGuideObjectModel;

  factory DigitalGuideObjectModel.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectModelFromJson(json);
}

@freezed
class DigitalGuideObjectTranslations with _$DigitalGuideObjectTranslations {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTranslations({
    required DigitalGuideObjectTranslation pl,
  }) = _DigitalGuideObjectTranslations;

  factory DigitalGuideObjectTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTranslationsFromJson(json);
}

@freezed
class DigitalGuideObjectTranslation with _$DigitalGuideObjectTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTranslation({
    required String name,
    required String address,
    required String accessibilityLevelForMotorDisabilityComment,
    required String accessibilityLevelForBlindComment,
    required String accessibilityLevelForVisuallyImpairedComment,
    String? accessibilityLevelForHardOfHearingComment,
    required String accessibilityLevelForHighSensorySensitivityComment,
    required String accessibilityLevelForCognitiveDifficultiesComment,
  }) = _Pl;

  factory DigitalGuideObjectTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTranslationFromJson(json);
}
