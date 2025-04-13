import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

import "../../../../utils/type_converter.dart";

part "digital_guide_object_model.freezed.dart";
part "digital_guide_object_model.g.dart";
part "digital_guide_object_model.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideObjectModel with _$DigitalGuideObjectModel, _$DigitalGuideObjectModelTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectModel({
    required int id,
    @translatableField required DigitalGuideObjectTranslations translations,
    String? linkToObjectLocation,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool isPossibilityToEnterWithAssistanceDog,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool isMicronavigationSystem,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool areGuidancePaths,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool areInformationBoardsWithBrailleDescription,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool areInformationBoardsWithLargeFont,
    @JsonKey(fromJson: _stringToInt, toJson: intToString) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: _stringToInt, toJson: intToString) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: _stringToInt, toJson: intToString) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: _stringToInt, toJson: intToString) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: _stringToInt, toJson: intToString) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: _stringToInt, toJson: intToString) required int accessibilityLevelForCognitiveDifficulties,
    String? locationMap,
    required List<int> images,
  }) = _DigitalGuideObjectModel;

  const DigitalGuideObjectModel._();

  factory DigitalGuideObjectModel.fromJson(Map<String, dynamic> json) => _$DigitalGuideObjectModelFromJson(json);
}

@freezed
abstract class DigitalGuideObjectTranslations with _$DigitalGuideObjectTranslations {
  const factory DigitalGuideObjectTranslations({@translatableField required DigitalGuideObjectTranslation pl}) =
      _DigitalGuideObjectTranslations;

  factory DigitalGuideObjectTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTranslationsFromJson(json);
}

@freezed
abstract class DigitalGuideObjectTranslation with _$DigitalGuideObjectTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTranslation({
    @translatableField required String name,
    required String address,
    @translatableField
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForMotorDisabilityComment,
    @translatableField @JsonKey(fromJson: _emptyStringToNull) required String? accessibilityLevelForBlindComment,
    @translatableField
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForVisuallyImpairedComment,
    @translatableField
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForHardOfHearingComment,
    @translatableField
    @JsonKey(fromJson: _emptyStringToNull)
    required String? accessibilityLevelForHighSensorySensitivityComment,
    @translatableField
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
