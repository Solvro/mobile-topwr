import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../utils/type_converter.dart";

part "digital_guide_response.freezed.dart";
part "digital_guide_response.g.dart";
part "digital_guide_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideResponse with _$DigitalGuideResponse, _$DigitalGuideResponseTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideResponse({
    required int id,
    required int? externalId,
    @translatableField required DigitalGuideTranslations translations,
    required int numberOfStoreys,
    @JsonKey(name: "is_possibility_to_enter_with_assistance_dog", fromJson: stringToBool, toJson: boolToString)
    required bool canAssistanceDog,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool isInductionLoop,
    @JsonKey(name: "is_micronavigation_system", fromJson: stringToBool, toJson: boolToString)
    required bool isMicroNavigationSystem,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool areGuidancePaths,
    @JsonKey(name: "are_information_boards_with_braille_description", fromJson: stringToBool, toJson: boolToString)
    required bool areBrailleBoards,
    @JsonKey(name: "are_information_boards_with_large_font", fromJson: stringToBool, toJson: boolToString)
    required bool areLargeFontBoards,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool isSignLanguageInterpreter,
    @JsonKey(fromJson: stringToBool, toJson: boolToString) required bool areEmergencyChairs,
    @JsonKey(name: "telephone_number", fromJson: _formatPhoneNumbers, toJson: _formatPhoneNumbersToJson)
    required List<String> phoneNumbers,
    @JsonKey(name: "surrounding") required int surroundingId,
    required List<int> images,
    @JsonKey(name: "evacuation_map") required int evacuationMapId,
    @JsonKey(name: "location_map") required int locationMapId,
    @JsonKey(name: "levels") required List<int> levelsIndices,
    @JsonKey(name: "access") required int accessId,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForMotorDisability,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForBlind,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForVisuallyImpaired,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForHardOfHearing,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForHighSensorySensitivity,
    @JsonKey(fromJson: stringToInt, toJson: intToString) required int accessibilityLevelForCognitiveDifficulties,
  }) = _DigitalGuideResponse;

  const DigitalGuideResponse._();

  factory DigitalGuideResponse.fromJson(Map<String, dynamic> json) => _$DigitalGuideResponseFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class DigitalGuideTranslations with _$DigitalGuideTranslations {
  const factory DigitalGuideTranslations({@JsonKey(name: "pl") required DigitalGuideTranslation plTranslation}) =
      _DigitalGuideTranslations;

  factory DigitalGuideTranslations.fromJson(Map<String, dynamic> json) => _$DigitalGuideTranslationsFromJson(json);
}

@freezed
abstract class DigitalGuideTranslation with _$DigitalGuideTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslation({
    required String name,
    required String extendedName,
    @nonTranslatableField required String address,
    required String evacuationDescription,
  }) = _DigitalGuideTranslation;

  factory DigitalGuideTranslation.fromJson(Map<String, dynamic> json) => _$DigitalGuideTranslationFromJson(json);
}

List<String> _formatPhoneNumbers(String phoneNumber) {
  final matches = RegExp(r"\d{9}").allMatches(phoneNumber.replaceAll("+48", "").replaceAll(RegExp(r"\D"), ""));
  return matches.map((match) => match.group(0)!).toList();
}

String _formatPhoneNumbersToJson(List<String> phoneNumbers) {
  return phoneNumbers.join(" ");
}
