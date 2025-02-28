import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_object_tab_model.freezed.dart";
part "digital_guide_object_tab_model.g.dart";

@freezed
class DigitalGuideObjectTabResponse with _$DigitalGuideObjectTabResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTabResponse({
    required int id,
    required DigitalGuideObjectTabTranslations translations,
    required String icon,
    required String activeIcon,
    required int object,
    required List<int> images,
  }) = _DigitalGuideObjectTabResponse;

  factory DigitalGuideObjectTabResponse.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTabResponseFromJson(json);
}

@freezed
class DigitalGuideObjectTabTranslations with _$DigitalGuideObjectTabTranslations {
  const factory DigitalGuideObjectTabTranslations({required DigitalGuideObjectTabTranslation pl}) =
      _DigitalGuideObjectTabTranslations;

  factory DigitalGuideObjectTabTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTabTranslationsFromJson(json);
}

@freezed
class DigitalGuideObjectTabTranslation with _$DigitalGuideObjectTabTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTabTranslation({
    required String name,
    required String content,
    required String accessibilityContentForMotorDisabilityComment,
    required String accessibilityContentForBlindComment,
    required String accessibilityContentForVisuallyImpairedComment,
    required String accessibilityContentForHardOfHearingComment,
    required String accessibilityContentForHighSensorySensitivityComment,
    required String accessibilityContentForCognitiveDifficultiesComment,
  }) = _DigitalGuideObjectTabTranslation;

  factory DigitalGuideObjectTabTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTabTranslationFromJson(json);
}
