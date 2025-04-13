import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "stairs.g.dart";
part "stairs.freezed.dart";
part "stairs.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Stairs with _$Stairs, _$StairsTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Stairs({
    required int id,
    @translatableField required StairsTranslations translations,
    required String isStairsSignInfo,
    required String isStairsSignInfoInEn,
    required String isGoodLit,
    required String isStairsSurfaceShiny,
    required String isNonslipSurface,
    required String isGoodStairsWallContrast,
    required String areEmergencyStairs,
    required String areFirstAndLastStepsMarked,
    required String areGradesNosePads,
    required String areStepsRaisedMarkings,
    required double stairsStepHeight,
    required String isProperlyMarkedFreeSpaceUnderStairs,
    @JsonKey(name: "railings") required IList<int> railingsIDs,
  }) = _Stairs;

  const Stairs._();

  factory Stairs.fromJson(Map<String, dynamic> json) => _$StairsFromJson(json);
}

@freezed
abstract class StairsTranslations with _$StairsTranslations {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StairsTranslations({@translatableField @JsonKey(name: "pl") required StairsTranslation plTranslation}) =
      _StairsTranslations;

  factory StairsTranslations.fromJson(Map<String, dynamic> json) => _$StairsTranslationsFromJson(json);
}

@freezed
abstract class StairsTranslation with _$StairsTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StairsTranslation({
    @translatableField required String location,
    @translatableField required String floorList,
    required String isStairsSignInfoComment,
    required String isStairsSignInfoInEnComment,
    required String stairsWidth,
    required String numberOfStairGears,
    required String numberOfStairLandings,
    required String isSameNumberOfStairsComment,
    required String isGoodLitComment,
    required String isStairsSurfaceShinyComment,
    required String isNonslipSurfaceComment,
    required String isGoodStairsWallContrastComment,
    required String areEmergencyStairsComment,
    required String areFirstAndLastStepsMarkedComment,
    required String areGradesNosePadsComment,
    required String areStepsRaisedMarkingsComment,
    required String isProperlyMarkedFreeSpaceUnderStairsComment,
    @translatableField required String comment,
  }) = _StairsTranslation;

  factory StairsTranslation.fromJson(Map<String, dynamic> json) => _$StairsTranslationFromJson(json);
}
