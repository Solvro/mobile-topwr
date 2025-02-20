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
    @JsonKey(fromJson: _stringToBool)
    required bool isPossibilityToEnterWithAssistanceDog,
    @JsonKey(fromJson: _stringToBool) required bool isMicronavigationSystem,
    @JsonKey(fromJson: _stringToBool) required bool areGuidancePaths,
    @JsonKey(fromJson: _stringToBool)
    required bool areInformationBoardsWithBrailleDescription,
    @JsonKey(fromJson: _stringToBool)
    required bool areInformationBoardsWithLargeFont,
    @JsonKey(fromJson: _stringToInt)
    required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: _stringToInt) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: _stringToInt)
    required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: _stringToInt)
    required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: _stringToInt)
    required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: _stringToInt)
    required int accessibilityLevelForCognitiveDifficulties,
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
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForMotorDisabilityComment,
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForBlindComment,
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForVisuallyImpairedComment,
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForHardOfHearingComment,
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForHighSensorySensitivityComment,
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForCognitiveDifficultiesComment,
  }) = _DigitalGuideObjectTranslation;

  factory DigitalGuideObjectTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTranslationFromJson(json);
}

int _stringToInt(String str) {
  return int.tryParse(str) ?? 1;
}

String? _emptyStringToNull(String str) {
  return str.isEmpty ? null : str;
}
