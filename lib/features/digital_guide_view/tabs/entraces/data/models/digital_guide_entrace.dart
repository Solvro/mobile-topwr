import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_entrace.freezed.dart";
part "digital_guide_entrace.g.dart";

@freezed
class DigitalGuideEntrace with _$DigitalGuideEntrace {
  const factory DigitalGuideEntrace({
    required int id,
    required DigitalGuideTranslationsEntrace translations,
    @JsonKey(name: "order_number", fromJson: _catchInt)
    required int orderNumber,
    @JsonKey(name: "is_main", fromJson: _stringToBool) required bool isMain,
    @JsonKey(name: "is_accessible", fromJson: _stringToBool)
    required bool isAccessible,
    @JsonKey(name: "is_for_personel", fromJson: _stringToBool)
    required bool isForPersonel,
    @JsonKey(name: "is_building_marked_from_entrance", fromJson: _stringToBool)
    required bool isBuildingMarkedFromEntrance,
    @JsonKey(name: "is_building_marked_in_en", fromJson: _stringToBool)
    required bool isBuildingMarkedInEn,
    @JsonKey(name: "is_lit", fromJson: _stringToBool) required bool isLit,
    @JsonKey(name: "is_emergency_exit", fromJson: _stringToBool)
    required bool isEmergencyExit,
    @JsonKey(name: "is_protection_from_weather", fromJson: _stringToBool)
    required bool isProtectionFromWeather,
    @JsonKey(name: "is_solid_surface", fromJson: _stringToBool)
    required bool isSolidSurface,
    @JsonKey(name: "are_different_types_of_surface", fromJson: _stringToBool)
    required bool areDifferentTypesOfSurface,
    @JsonKey(name: "are_benches", fromJson: _stringToBool)
    required bool areBenches,
    @JsonKey(name: "number_of_doors", fromJson: _catchInt)
    required int numberOfDoors,
    @JsonKey(name: "doors_distance", fromJson: _stringToInt)
    required int doorsDistance,
    @JsonKey(name: "has_sound_transmitter", fromJson: _stringToBool)
    required bool hasSoundTransmitter,
    @JsonKey(name: "has_tactile_paving", fromJson: _stringToBool)
    required bool hasTactilePaving,
    @JsonKey(name: "building", fromJson: _catchInt) required int building,
    @JsonKey(name: "stairs") required IList<int> stairsIndices,
    @JsonKey(name: "lifts") required IList<int> liftsIndices,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
    @JsonKey(name: "ramps") required IList<int> rampsIndices,
    @JsonKey(name: "images") required IList<int> imagesIndices,
  }) = _DigitalGuideEntrace;

  factory DigitalGuideEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideEntraceFromJson(json);
}

@freezed
class DigitalGuideTranslationsEntrace with _$DigitalGuideTranslationsEntrace {
  const factory DigitalGuideTranslationsEntrace({
    @JsonKey(name: "pl") required DigitalGuideTranslationEntrace pl,
  }) = _DigitalGuideTranslationsEntrace;

  factory DigitalGuideTranslationsEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsEntraceFromJson(json);
}

@freezed
class DigitalGuideTranslationEntrace with _$DigitalGuideTranslationEntrace {
  const factory DigitalGuideTranslationEntrace({
    @JsonKey(fromJson: _catchString) required String name,
    @JsonKey(fromJson: _catchString) required String location,
    @JsonKey(fromJson: _catchString) required String isMainComment,
    @JsonKey(fromJson: _catchString) required String isForPersonelComment,
    @JsonKey(fromJson: _catchString)
    required String isBuildingMarkedFromEntranceComment,
    @JsonKey(fromJson: _catchString)
    required String isBuildingMarkedInEnComment,
    @JsonKey(fromJson: _catchString) required String isLitComment,
    @JsonKey(fromJson: _catchString) required String isEmergencyExitComment,
    @JsonKey(fromJson: _catchString)
    required String isProtectionFromWeatherComment,
    @JsonKey(fromJson: _catchString) required String isSolidSurfaceComment,
    @JsonKey(fromJson: _catchString)
    required String areDifferentTypesOfSurfaceComment,
    @JsonKey(fromJson: _catchString) required String areBenchesComment,
    @JsonKey(fromJson: _catchString) required String entranceThreats,
    @JsonKey(fromJson: _catchString) required String hasSoundTransmitterComment,
    @JsonKey(fromJson: _catchString) required String hasTactilePavingComment,
    @JsonKey(fromJson: _catchString) required String comment,
  }) = _DigitalGuideTranslationEntrace;

  factory DigitalGuideTranslationEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationEntraceFromJson(json);
}

bool _stringToBool(String str) {
  return str.toLowerCase() == "true";
}

int _stringToInt(String str) {
  return int.tryParse(str) ?? 1;
}

int _catchInt(int? intiger) {
  return intiger ?? 0;
}

String _catchString(String? str) {
  return str ?? "";
}
