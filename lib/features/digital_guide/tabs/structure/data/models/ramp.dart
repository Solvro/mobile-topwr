import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "ramp.freezed.dart";
part "ramp.g.dart";
part "ramp.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Ramp with _$Ramp, _$RampTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Ramp({
    @translatableField required RampTranslations translations,
    required String isRampMarked,
    required String isIncreasedForceNeeded,
    required String isPermanentRamp,
    required double rampWidth,
    required String isGoodLit,
    required String areNonslipElements,
    @JsonKey(name: "railings") required IList<int> railingsIDs,
  }) = _Ramp;

  const Ramp._();

  factory Ramp.fromJson(Map<String, dynamic> json) => _$RampFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class RampTranslations with _$RampTranslations {
  const factory RampTranslations({@JsonKey(name: "pl") required RampTranslation plTranslation}) = _RampTranslations;

  factory RampTranslations.fromJson(Map<String, dynamic> json) => _$RampTranslationsFromJson(json);
}

@freezed
abstract class RampTranslation with _$RampTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RampTranslation({
    required String location,
    required String isRampMarkedComment,
    required String isIncreasedForceNeededComment,
    required String isPermanentRampComment,
    required String numberOfLandings,
    required String dimensionsOfTheLandings,
    required String isGoodLitComment,
    required String areNonslipElementsComment,
    required String comment,
  }) = _RampTranslation;

  factory RampTranslation.fromJson(Map<String, dynamic> json) => _$RampTranslationFromJson(json);
}
