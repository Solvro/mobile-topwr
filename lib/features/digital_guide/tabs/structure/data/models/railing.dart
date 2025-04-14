import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "railing.g.dart";
part "railing.freezed.dart";
part "railing.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Railing with _$Railing, _$RailingTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Railing({
    @translatableField required RailingTranslations translations,
    required String isRailingOnLandings,
    double? railingHeight,
    required String isTwoSidedRailing,
    required String isBrailleConvexMarking,
    required String isGoodRailingContrast,
    required String isRoundCrossSectionRailing,
    @JsonKey(name: "is_railing_extended_30cm") required String isRailingExtended30cm,
    required String isRailingObstacle,
  }) = _Railing;

  const Railing._();

  factory Railing.fromJson(Map<String, dynamic> json) => _$RailingFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class RailingTranslations with _$RailingTranslations {
  const factory RailingTranslations({@JsonKey(name: "pl") required RailingTranslation plTranslation}) =
      _RailingTranslations;

  factory RailingTranslations.fromJson(Map<String, dynamic> json) => _$RailingTranslationsFromJson(json);
}

@freezed
abstract class RailingTranslation with _$RailingTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RailingTranslation({
    required String isRailingOnLandingsComment,
    required String isTwoSidedRailingComment,
    required String isBrailleConvexMarkingComment,
    required String isGoodRailingContrastComment,
    required String isRoundCrossSectionRailingComment,
    @JsonKey(name: "is_railing_extended_30cm_comment") required String isRailingExtended30cmComment,
    required String isRailingObstacleComment,
    required String comment,
  }) = _RailingTranslation;

  factory RailingTranslation.fromJson(Map<String, dynamic> json) => _$RailingTranslationFromJson(json);
}
