import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "room_stairs_response.freezed.dart";
part "room_stairs_response.g.dart";
part "room_stairs_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class RoomStairsResponse with _$RoomStairsResponse, _$RoomStairsResponseTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RoomStairsResponse({
    required int id,
    @translatableField required RoomStairsTranslations translations,
    required double stairsWidth,
    required String isGoodLit,
    required String isNonslipSurface,
    required String isStairsSurfaceShiny,
    required String isGoodStairsWallContrast,
    required String areStepsEdgesMarkedInContrastedWay,
    required String areAllStepsHaveSameDimensions,
    required String isRailing,
    required double railingHeight,
    required String isGoodRailingContrast,
    required String isRoundCrossSectionRailing,
    required String isRailingOnRamp,
    required String isEdgeBetweenRampRowEntranceMarked,
  }) = _RoomStairsResponse;

  const RoomStairsResponse._();

  factory RoomStairsResponse.fromJson(Map<String, dynamic> json) => _$RoomStairsResponseFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class RoomStairsTranslations with _$RoomStairsTranslations {
  const factory RoomStairsTranslations({required RoomStairsTranslation pl}) = _RoomStairsTranslations;

  factory RoomStairsTranslations.fromJson(Map<String, dynamic> json) => _$RoomStairsTranslationsFromJson(json);
}

@freezed
abstract class RoomStairsTranslation with _$RoomStairsTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RoomStairsTranslation({
    required String location,
    required String isGoodLitComment,
    required String isNonslipSurfaceComment,
    required String isStairsSurfaceShinyComment,
    required String isGoodStairsWallContrastComment,
    required String areStepsEdgesMarkedInContrastedWayComment,
    required String areAllStepsHaveSameDimensionsComment,
    required String isRailingComment,
    required String isGoodRailingContrastComment,
    required String isRoundCrossSectionRailingComment,
    required String isRamp,
    required String isRailingOnRampComment,
    required String isEdgeBetweenRampRowEntranceMarkedComment,
    required String comment,
  }) = _RoomStairsTranslation;

  factory RoomStairsTranslation.fromJson(Map<String, dynamic> json) => _$RoomStairsTranslationFromJson(json);
}
