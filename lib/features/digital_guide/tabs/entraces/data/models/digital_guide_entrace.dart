import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_entrace.freezed.dart";
part "digital_guide_entrace.g.dart";

@freezed
abstract class DigitalGuideEntrace with _$DigitalGuideEntrace {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideEntrace({
    required int id,
    required DigitalGuideTranslationsEntrace translations,
    required int orderNumber,
    required String isMain,
    required String isAccessible,
    required String isForPersonel,
    required String isBuildingMarkedFromEntrance,
    required String isBuildingMarkedInEn,
    required String isLit,
    required String isEmergencyExit,
    required String isProtectionFromWeather,
    required String isSolidSurface,
    required String areDifferentTypesOfSurface,
    required String areBenches,
    required int numberOfDoors,
    required String doorsDistance,
    required String hasSoundTransmitter,
    required String hasTactilePaving,
    required int? building,
    @JsonKey(name: "stairs") required IList<int> stairsIndices,
    @JsonKey(name: "lifts") required IList<int> liftsIndices,
    @JsonKey(name: "doors") required IList<int> doorsIndices,
    @JsonKey(name: "ramps") required IList<int> rampsIndices,
    @JsonKey(name: "images") required IList<int> imagesIndices,
  }) = _DigitalGuideEntrace;

  factory DigitalGuideEntrace.fromJson(Map<String, dynamic> json) => _$DigitalGuideEntraceFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationsEntrace with _$DigitalGuideTranslationsEntrace {
  const factory DigitalGuideTranslationsEntrace({@JsonKey(name: "pl") required DigitalGuideTranslationEntrace pl}) =
      _DigitalGuideTranslationsEntrace;

  factory DigitalGuideTranslationsEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsEntraceFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationEntrace with _$DigitalGuideTranslationEntrace {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationEntrace({
    required String name,
    required String location,
    required String isMainComment,
    required String isForPersonelComment,
    required String isBuildingMarkedFromEntranceComment,
    required String isBuildingMarkedInEnComment,
    required String isLitComment,
    required String isEmergencyExitComment,
    required String isProtectionFromWeatherComment,
    required String isSolidSurfaceComment,
    required String areDifferentTypesOfSurfaceComment,
    required String areBenchesComment,
    required String entranceThreats,
    required String hasSoundTransmitterComment,
    required String hasTactilePavingComment,
    required String comment,
  }) = _DigitalGuideTranslationEntrace;

  factory DigitalGuideTranslationEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationEntraceFromJson(json);
}
