import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "digital_guide_object_tab_model.freezed.dart";
part "digital_guide_object_tab_model.g.dart";
part "digital_guide_object_tab_model.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideObjectTabResponse
    with _$DigitalGuideObjectTabResponse, _$DigitalGuideObjectTabResponseTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTabResponse({
    required int id,
    @translatableField required DigitalGuideObjectTabTranslations translations,
    required String icon,
    required String activeIcon,
    required int object,
    required List<int> images,
  }) = _DigitalGuideObjectTabResponse;

  const DigitalGuideObjectTabResponse._();

  factory DigitalGuideObjectTabResponse.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTabResponseFromJson(json);
}

@freezed
abstract class DigitalGuideObjectTabTranslations with _$DigitalGuideObjectTabTranslations {
  const factory DigitalGuideObjectTabTranslations({@translatableField required DigitalGuideObjectTabTranslation pl}) =
      _DigitalGuideObjectTabTranslations;

  factory DigitalGuideObjectTabTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTabTranslationsFromJson(json);
}

@freezed
abstract class DigitalGuideObjectTabTranslation with _$DigitalGuideObjectTabTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideObjectTabTranslation({
    @translatableField required String name,
    @translatableField required String content,
    @translatableField required String accessibilityContentForMotorDisabilityComment,
    @translatableField required String accessibilityContentForBlindComment,
    @translatableField required String accessibilityContentForVisuallyImpairedComment,
    @translatableField required String accessibilityContentForHardOfHearingComment,
    @translatableField required String accessibilityContentForHighSensorySensitivityComment,
    @translatableField required String accessibilityContentForCognitiveDifficultiesComment,
  }) = _DigitalGuideObjectTabTranslation;

  factory DigitalGuideObjectTabTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideObjectTabTranslationFromJson(json);
}
