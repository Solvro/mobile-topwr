import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_lift.freezed.dart";

part "digital_guide_lift.g.dart";

@freezed
class DigitalGuideLift with _$DigitalGuideLift {
  const factory DigitalGuideLift({
    required int id,
    required DigitalGuideTranslationsLift translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
  }) = _DigitalGuideLift;

  factory DigitalGuideLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideLiftFromJson(json);
}

@freezed
class DigitalGuideTranslationsLift with _$DigitalGuideTranslationsLift {
  const factory DigitalGuideTranslationsLift({
    required DigitalGuideTranslationLift pl,
  }) = _DigitalGuideTranslationsLift;

  factory DigitalGuideTranslationsLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsLiftFromJson(json);
}

@freezed
class DigitalGuideTranslationLift with _$DigitalGuideTranslationLift {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationLift({
    required String location,
    required String floorsList,
    required String maximumLiftCapacity,
    required String liftDimensions,
  }) = _DigitalGuideTranslationLift;

  factory DigitalGuideTranslationLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationLiftFromJson(json);
}
