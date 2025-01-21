import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "corridor.freezed.dart";
part "corridor.g.dart";

@freezed
class Corridor with _$Corridor {

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Corridor({
    required CorridorTranslations translations,
    @JsonKey(fromJson: stringToBool)
    required bool isSimpleCorridorLayout,
    @JsonKey(fromJson: stringToBool)
    required bool isFloorMarked,
    @JsonKey(fromJson: stringToBool)
    required bool areRoomsEntrances,
    @JsonKey(fromJson: stringToBool)
    required bool isInformationBoard,
    @JsonKey(fromJson: stringToBool)
    required bool areRoomPurposeDescribedInEn,
    @JsonKey(fromJson: stringToBool)
    required bool isConsistentLevelColorPattern,
    @JsonKey(fromJson: stringToBool)
    required bool arePictorialDirectionalSigns,
    @JsonKey(fromJson: stringToBool) required bool areSeats,
    @JsonKey(fromJson: stringToBool)
    required bool areVendingMachines,
    @JsonKey(fromJson: stringToBool)
    required bool isEmergencyPlan,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
    @JsonKey(name: "images") required IList<int> imagesIndices,
  }) = _Corridor;

  factory Corridor.fromJson(Map<String, dynamic> json) =>
      _$CorridorFromJson(json);
}

@freezed
class CorridorTranslations with _$CorridorTranslations {
  const factory CorridorTranslations({
    @JsonKey(name: "pl") required CorridorTranslation plTranslation,
  }) = _CorridorTranslations;

  factory CorridorTranslations.fromJson(Map<String, dynamic> json) =>
      _$CorridorTranslationsFromJson(json);
}

@freezed
class CorridorTranslation with _$CorridorTranslation {

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CorridorTranslation({
    required String name,
    required String isSimpleCorridorLayoutComment,
    required String isFloorMarkedComment,
    required String areRoomsEntrancesComment,
    required String isInformationBoardComment,
    required String arePictorialDirectionalSignsComment,
    required String areSeatsComment,
    required String areVendingMachinesComment,
    required String vendingMachinesProducts,
    required String comment,
  }) = _CorridorTranslation;

  factory CorridorTranslation.fromJson(Map<String, dynamic> json) =>
      _$CorridorTranslationFromJson(json);
}

bool stringToBool(String text) {
  return text.toLowerCase() == "true";
}
