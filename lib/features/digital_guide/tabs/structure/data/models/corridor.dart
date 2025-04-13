import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "corridor.freezed.dart";
part "corridor.g.dart";
part "corridor.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Corridor with _$Corridor, _$CorridorTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Corridor({
    @translatableField required CorridorTranslations translations,
    required String isSimpleCorridorLayout,
    required String isFloorMarked,
    required String areRoomsEntrances,
    required String isInformationBoard,
    required String areRoomPurposeDescribedInEn,
    required String isConsistentLevelColorPattern,
    required String arePictorialDirectionalSigns,
    required String areSeats,
    required String areVendingMachines,
    required String isEmergencyPlan,
    required String isTyphlomap,
    required String areDangerousElements,
    required String arePlatesInfoAccessible,
    required String areHorizontalMarkingsForBlind,
    required String arePlatesWithRoomsListHaveReadableFont,
    required String areRoomsMarked,
    required String arePictogramsUsed,
    required String isGlare,
    required String isGoodWallsColorContrast,
    required String isGoodLit,
    required String areHorizontalMarkingsForVisuallyImpaired,
    required String isEnoughMinWidthLength,
    required String areRailings,
    required String isCorrectLightSwitchesSocketsHeight,
    required String isCorridorCausesEcho,
    required String areAnyFlashingDevices,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
    @JsonKey(name: "images") required IList<int> imagesIndices,
  }) = _Corridor;

  const Corridor._();

  factory Corridor.fromJson(Map<String, dynamic> json) => _$CorridorFromJson(json);
}

@freezed
abstract class CorridorTranslations with _$CorridorTranslations {
  const factory CorridorTranslations({
    @translatableField @JsonKey(name: "pl") required CorridorTranslation plTranslation,
  }) = _CorridorTranslations;

  factory CorridorTranslations.fromJson(Map<String, dynamic> json) => _$CorridorTranslationsFromJson(json);
}

@freezed
abstract class CorridorTranslation with _$CorridorTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CorridorTranslation({
    @translatableField required String name,
    required String isSimpleCorridorLayoutComment,
    required String isFloorMarkedComment,
    required String areRoomsEntrancesComment,
    required String isInformationBoardComment,
    required String areRoomPurposeDescribedInEnComment,
    required String isConsistentLevelColorPatternComment,
    required String arePictorialDirectionalSignsComment,
    required String areSeatsComment,
    required String areVendingMachinesComment,
    @translatableField required String vendingMachinesProducts,
    required String isEmergencyPlanComment,
    required String isTyphlomapComment,
    required String areDangerousElementsComment,
    required String arePlatesInfoAccessibleComment,
    required String areHorizontalMarkingsForBlindComment,
    required String arePlatesWithRoomsListHaveReadableFontComment,
    required String areRoomsMarkedComment,
    required String arePictogramsUsedComment,
    required String isGlareComment,
    required String isGoodWallsColorContrastComment,
    required String isGoodLitComment,
    required String areHorizontalMarkingsForVisuallyImpairedComment,
    required String isEnoughMinWidthLengthComment,
    required String areRailingsComment,
    required String isCorrectLightSwitchesSocketsHeightComment,
    required String isCorridorCausesEchoComment,
    required String areAnyFlashingDevicesComment,
    @translatableField required String comment,
  }) = _CorridorTranslation;

  factory CorridorTranslation.fromJson(Map<String, dynamic> json) => _$CorridorTranslationFromJson(json);
}
