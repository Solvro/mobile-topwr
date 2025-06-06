import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "digital_guide_lodge.freezed.dart";
part "digital_guide_lodge.g.dart";
part "digital_guide_lodge.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideLodge with _$DigitalGuideLodge, _$DigitalGuideLodgeTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideLodge({
    required int id,
    @translatableField required DigitalGuideTranslationsLodge translations,
    required String areAccessBarriers,
    required String isMovementSpace,
    required double counterHeight,
    required String isSpaceUnderCounter,
    required String isVisibleFromAfar,
    required String isGoodLit,
    @JsonKey(name: "images") required List<int>? imagesIds,
  }) = _DigitalGuideLodge;

  const DigitalGuideLodge._();

  factory DigitalGuideLodge.fromJson(Map<String, dynamic> json) => _$DigitalGuideLodgeFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class DigitalGuideTranslationsLodge with _$DigitalGuideTranslationsLodge {
  const factory DigitalGuideTranslationsLodge({required DigitalGuideTranslationLodge pl}) =
      _DigitalGuideTranslationsLodge;

  factory DigitalGuideTranslationsLodge.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsLodgeFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationLodge with _$DigitalGuideTranslationLodge {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationLodge({
    required String location,
    required String workingDaysAndHours,
    required String comment,
    required String areAccessBarriersComment,
    required String isMovementSpaceComment,
    required String isSpaceUnderCounterComment,
    required String isVisibleFromAfarComment,
    required String isGoodLitComment,
  }) = _DigitalGuideTranslationLodge;
  factory DigitalGuideTranslationLodge.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationLodgeFromJson(json);
}
