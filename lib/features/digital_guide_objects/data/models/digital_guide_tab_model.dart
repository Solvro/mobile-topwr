import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_tab_model.freezed.dart";
part "digital_guide_tab_model.g.dart";

@freezed
class DigitalGuideTabModel with _$DigitalGuideTabModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTabModel({
    required int id,
    required Translations translations,
    required String icon,
    required String activeIcon,
    required int object,
    required List<int> images,
  }) = _DigitalGuideTabModel;

  factory DigitalGuideTabModel.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTabModelFromJson(json);
}

@freezed
class Translations with _$Translations {
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
    required String content,
    required String accessibilityContentForMotorDisabilityComment,
    required String accessibilityContentForBlindComment,
    required String accessibilityContentForVisuallyImpairedComment,
    required String accessibilityContentForHardOfHearingComment,
    required String accessibilityContentForHighSensorySensitivityComment,
    required String accessibilityContentForCognitiveDifficultiesComment,
  }) = _Pl;

  factory Pl.fromJson(Map<String, dynamic> json) => _$PlFromJson(json);
}
