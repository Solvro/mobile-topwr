import "package:freezed_annotation/freezed_annotation.dart";

part "stairs.g.dart";
part "stairs.freezed.dart";

@freezed
class Stairs with _$Stairs {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Stairs({
    required StairsTranslations translations,
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
  }) = _Stairs;

  factory Stairs.fromJson(Map<String, dynamic> json) => _$StairsFromJson(json);
}

@freezed
class StairsTranslations with _$StairsTranslations {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StairsTranslations({
    @JsonKey(name: "pl") required StairsTranslation plTranslation,
  }) = _StairsTranslations;

  factory StairsTranslations.fromJson(Map<String, dynamic> json) =>
      _$StairsTranslationsFromJson(json);
}

@freezed
class StairsTranslation with _$StairsTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StairsTranslation({
    required String location,
    required String floorList,
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
    required String comment,
  }) = _StairsTranslation;

  factory StairsTranslation.fromJson(Map<String, dynamic> json) =>
      _$StairsTranslationFromJson(json);
}
