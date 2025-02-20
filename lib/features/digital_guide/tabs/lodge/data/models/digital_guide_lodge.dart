import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_lodge.freezed.dart";
part "digital_guide_lodge.g.dart";

@freezed
class DigitalGuideLodge with _$DigitalGuideLodge {
  const factory DigitalGuideLodge({
    required int id,
    required DigitalGuideTranslationsLodge translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
  }) = _DigitalGuideLodge;

  factory DigitalGuideLodge.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideLodgeFromJson(json);
}

@freezed
class DigitalGuideTranslationsLodge with _$DigitalGuideTranslationsLodge {
  const factory DigitalGuideTranslationsLodge({
    required DigitalGuideTranslationLodge pl,
  }) = _DigitalGuideTranslationsLodge;

  factory DigitalGuideTranslationsLodge.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsLodgeFromJson(json);
}

@freezed
class DigitalGuideTranslationLodge with _$DigitalGuideTranslationLodge {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationLodge({
    required String location,
    required String workingDaysAndHours,
    required String comment,
  }) = _DigitalGuideTranslationLodge;
  factory DigitalGuideTranslationLodge.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationLodgeFromJson(json);
}
