import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_entrace.freezed.dart";
part "digital_guide_entrace.g.dart";

@freezed
class DigitalGuideEntrace with _$DigitalGuideEntrace {
  const factory DigitalGuideEntrace({
    required int id,
    required DigitalGuideTranslationsEntrace translations,
    @JsonKey(
      name: "is_lit",
      fromJson: _stringToBool,
    )
    required bool isLit,
    @JsonKey(
      name: "is_for_personel",
      fromJson: _stringToBool,
    )
    required bool isForPersonnel,

    @JsonKey(
      name: "is_building_marked_from_entrance",
      fromJson: _stringToBool,
    )
    required bool isBuildingMarkedFromEntrance,

    @JsonKey(
      name: "is_emergency_exit",
      fromJson: _stringToBool,
    )
    required bool isEmergencyExit,

    @JsonKey(
      name: "is_protection_from_weather",
      fromJson: _stringToBool,
    )
    required bool isProtectionFromWeather,

    @JsonKey(
      name: "is_solid_surface",
      fromJson: _stringToBool,
    )
    required bool isSolidSurface,
  }) = _DigitalGuideEntrace;

  factory DigitalGuideEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideEntraceFromJson(json);
}

@freezed
class DigitalGuideTranslationsEntrace with _$DigitalGuideTranslationsEntrace {
  const factory DigitalGuideTranslationsEntrace({
    required DigitalGuideTranslationEntrace pl,
  }) = _DigitalGuideTranslationsEntrace;

  factory DigitalGuideTranslationsEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsEntraceFromJson(json);
}

@freezed
class DigitalGuideTranslationEntrace with _$DigitalGuideTranslationEntrace {
  const factory DigitalGuideTranslationEntrace({
    required String name,
    required String location,
  }) = _DigitalGuideTranslationEntrace;

  factory DigitalGuideTranslationEntrace.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationEntraceFromJson(json);
}


bool _stringToBool(String value) {
  return value.toLowerCase() == "true";
}
