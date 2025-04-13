import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../services/translations_service/data/models/translatable.dart";

part "ramp.freezed.dart";
part "ramp.g.dart";

@freezed
abstract class Ramp with _$Ramp implements Translatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Ramp({
    required RampTranslations translations,
    required String isRampMarked,
    required String isIncreasedForceNeeded,
    required String isPermanentRamp,
    required double rampWidth,
    required String isGoodLit,
    required String areNonslipElements,
    @JsonKey(name: "railings") required IList<int> railingsIDs,
  }) = _Ramp;

  factory Ramp.fromJson(Map<String, dynamic> json) => _$RampFromJson(json);
}

@freezed
abstract class RampTranslations with _$RampTranslations {
  @JsonSerializable(fieldRename: FieldRename.snake)
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
