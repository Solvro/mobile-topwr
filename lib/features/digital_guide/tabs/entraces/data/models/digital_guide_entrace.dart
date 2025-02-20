import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_entrace.freezed.dart";
part "digital_guide_entrace.g.dart";

@freezed
class DigitalGuideEntrace with _$DigitalGuideEntrace {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideEntrace({
    required int id,
    required DigitalGuideTranslationsEntrace translations,
    required int orderNumber,
    @JsonKey(fromJson: _stringToBool) required bool isMain,
    @JsonKey(fromJson: _stringToBool) required bool isAccessible,
    @JsonKey(fromJson: _stringToBool) required bool isForPersonel,
    @JsonKey(fromJson: _stringToBool)
    required bool isBuildingMarkedFromEntrance,
    @JsonKey(fromJson: _stringToBool) required bool isBuildingMarkedInEn,
    @JsonKey(fromJson: _stringToBool) required bool isLit,
    @JsonKey(fromJson: _stringToBool) required bool isEmergencyExit,
    @JsonKey(fromJson: _stringToBool) required bool isProtectionFromWeather,
    @JsonKey(fromJson: _stringToBool) required bool isSolidSurface,
    @JsonKey(fromJson: _stringToBool) required bool areDifferentTypesOfSurface,
    @JsonKey(fromJson: _stringToBool) required bool areBenches,
    required int? numberOfDoors,
    required String? doorsDistance,
    @JsonKey(fromJson: _stringToBool) required bool hasSoundTransmitter,
    @JsonKey(fromJson: _stringToBool) required bool hasTactilePaving,
    required int? building,
    required IList<int> stairsIndices,
    required IList<int> liftsIndices,
    required IList<int> doorsIndices,
    required IList<int> rampsIndices,
    required IList<int> imagesIndices,
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
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationEntrace({
    required String? name,
    required String? location,
    required String? isMainComment,
    required String? isForPersonelComment,
    required String? isBuildingMarkedFromEntranceComment,
    required String? isBuildingMarkedInEnComment,
    required String? isLitComment,
    required String? isEmergencyExitComment,
    required String? isProtectionFromWeatherComment,
    required String? isSolidSurfaceComment,
    required String? areDifferentTypesOfSurfaceComment,
    required String? areBenchesComment,
    required String? entranceThreats,
    required String? hasSoundTransmitterComment,
    required String? hasTactilePavingComment,
    required String? comment,
  }) = _DigitalGuideTranslationEntrace;

  factory DigitalGuideTranslationEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationEntraceFromJson(json);
}

bool _stringToBool(String? str) {
  if (str == null) {
    return false;
  }
  if (str == "") {
    return true;
  }
  return str.toLowerCase() == "true";
}

String toNonNullString(dynamic value) {
  return value?.toString() ?? "";
}

IList<String> getNonNullableList(List<String?> items) {
  return items.where((item) => item != null).cast<String>().toIList();
}
