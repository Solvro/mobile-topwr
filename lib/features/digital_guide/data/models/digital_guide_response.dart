import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_response.freezed.dart";
part "digital_guide_response.g.dart";

@freezed
class DigitalGuideResponse with _$DigitalGuideResponse {
  const factory DigitalGuideResponse({
    required int id,
    @JsonKey(name: "external_id") required int externalId,
    required DigitalGuideTranslations translations,
    @JsonKey(name: "number_of_storeys") required int numberOfStoreys,
    @JsonKey(
      name: "is_possibility_to_enter_with_assistance_dog",
      fromJson: _stringToBool,
    )
    required bool canAssistanceDog,
    @JsonKey(
      name: "is_induction_loop",
      fromJson: _stringToBool,
    )
    required bool isInductionLoop,
    @JsonKey(
      name: "is_micronavigation_system",
      fromJson: _stringToBool,
    )
    required bool isMicroNavigationSystem,
    @JsonKey(
      name: "are_guidance_paths",
      fromJson: _stringToBool,
    )
    required bool areGuidancePaths,
    @JsonKey(
      name: "are_information_boards_with_braille_description",
      fromJson: _stringToBool,
    )
    required bool areBrailleBoards,
    @JsonKey(
      name: "are_information_boards_with_large_font",
      fromJson: _stringToBool,
    )
    required bool areLargeFontBoards,
    @JsonKey(
      name: "is_sign_language_interpreter",
      fromJson: _stringToBool,
    )
    required bool isSignLanguageInterpreter,
    @JsonKey(
      name: "are_emergency_chairs",
      fromJson: _stringToBool,
    )
    required bool areEmergencyChairs,
    @JsonKey(name: "telephone_number", fromJson: _formatPhoneNumbers)
    required List<String> phoneNumbers,
    @JsonKey(name: "surrounding") required int surroundingId,
    required List<int> images,
    @JsonKey(name: "evacuation_map") required int evacuationMapId,
    @JsonKey(name: "location_map") required int locationMapId,
    @JsonKey(name: "levels") required List<int> levelsIndices,
  }) = _DigitalGuideResponse;

  factory DigitalGuideResponse.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideResponseFromJson(json);
}

@freezed
class DigitalGuideTranslations with _$DigitalGuideTranslations {
  const factory DigitalGuideTranslations({
    @JsonKey(name: "pl") required DigitalGuideTranslation plTranslation,
  }) = _DigitalGuideTranslations;

  factory DigitalGuideTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsFromJson(json);
}

@freezed
class DigitalGuideTranslation with _$DigitalGuideTranslation {
  const factory DigitalGuideTranslation({
    required String name,
    @JsonKey(name: "extended_name") required String extendedName,
    required String address,
    @JsonKey(name: "evacuation_description")
    required String evacuationDescription,
  }) = _DigitalGuideTranslation;

  factory DigitalGuideTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationFromJson(json);
}

bool _stringToBool(String value) {
  return value.toLowerCase() == "true";
}

List<String> _formatPhoneNumbers(String phoneNumber) {
  final matches = RegExp(r"\d{9}").allMatches(
    phoneNumber.replaceAll("+48", "").replaceAll(RegExp(r"\D"), ""),
  );
  return matches.map((match) => match.group(0)!).toList();
}
