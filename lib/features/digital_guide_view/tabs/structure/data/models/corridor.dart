import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "corridor.freezed.dart";
part "corridor.g.dart";

@freezed
class Corridor with _$Corridor {
  const factory Corridor({
    required CorridorTranslations translations,
    @JsonKey(name: "is_simple_corridor_layout", fromJson: stringToBool) required bool isSimpleCorridorLayout,
    @JsonKey(name: "is_floor_marked", fromJson: stringToBool) required bool isFloorMarked,
    @JsonKey(name: "are_rooms_entrances", fromJson: stringToBool) required bool areRoomEntrances,
    @JsonKey(name: "is_information_board", fromJson: stringToBool) required bool isInformationBoard,
    @JsonKey(name: "are_room_purpose_described_in_en", fromJson: stringToBool) required bool areRoomPurposeDescribedInEn,
    @JsonKey(name: "is_consistent_level_color_pattern", fromJson: stringToBool) required bool isConsistentLevelColorPattern,
    @JsonKey(name: "are_pictorial_directional_signs", fromJson: stringToBool) required bool arePictorialdirectionalSigns,
    @JsonKey(name: "are_seats", fromJson: stringToBool) required bool areSeats,
    @JsonKey(name: "are_vending_machines", fromJson: stringToBool) required bool areVendingMachines,
    @JsonKey(name: "is_emergency_plan", fromJson: stringToBool) required bool isEmergencyPlan,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
    @JsonKey(name: "images") required IList<int> imagesIndices,
  }) = _Corridor;

  factory Corridor.fromJson(Map<String, dynamic> json) => _$CorridorFromJson(json);
}

@freezed
class CorridorTranslations with _$CorridorTranslations {
  const factory CorridorTranslations ({
    @JsonKey(name: "pl") required CorridorTranslation plTranslation,
  }) = _CorridorTranslations;

  factory CorridorTranslations.fromJson(Map<String, dynamic> json) => _$CorridorTranslationsFromJson(json);
}

@freezed
class CorridorTranslation with _$CorridorTranslation {
  const factory CorridorTranslation ({
    required String name,
    @JsonKey(name: "is_simple_corridor_layout_comment") required String simpleCorridorLayoutComment,
    @JsonKey(name: "is_floor_marked_comment") required String floorMarkedComment,
    @JsonKey(name: "are_rooms_entrances_comment") required String roomEntrancesComment,
    @JsonKey(name: "is_information_board_comment") required String informationBoardComment,
    @JsonKey(name: "are_pictorial_directional_signs_comment") required String pictorialDirectionalSignsComment,
    @JsonKey(name: "are_seats_comment") required String seatsComment,
    @JsonKey(name: "are_vending_machines_comment") required String vendingMachinesComment,
    @JsonKey(name: "vending_machines_products") required String vendingMachinesProducts,
    required String comment,
  }) = _CorridorTranslation;

  factory CorridorTranslation.fromJson(Map<String,dynamic> json) => _$CorridorTranslationFromJson(json);
}

bool stringToBool(String text) {
  return text == "True";
}
