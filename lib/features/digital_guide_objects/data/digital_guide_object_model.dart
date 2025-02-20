import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_object_model.freezed.dart";
part "digital_guide_object_model.g.dart";

@freezed
class DigitalGuideObjectModel with _$DigitalGuideObjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectModel({
    required int id,
    required Translations translations,
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
class Translations with _$Translations {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Translations({
    required Pl pl,
  }) = _Translations;

  factory Translations.fromJson(Map<String, dynamic> json) =>
      _$TranslationsFromJson(json);
}

@freezed
class Pl with _$Pl {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Pl({
    required String name,
    required String address,
    required String accessibilityLevelForMotorDisabilityComment,
    required String accessibilityLevelForBlindComment,
    required String accessibilityLevelForVisuallyImpairedComment,
    String? accessibilityLevelForHardOfHearingComment,
    required String accessibilityLevelForHighSensorySensitivityComment,
    required String accessibilityLevelForCognitiveDifficultiesComment,
  }) = _Pl;

  factory Pl.fromJson(Map<String, dynamic> json) => _$PlFromJson(json);
}
