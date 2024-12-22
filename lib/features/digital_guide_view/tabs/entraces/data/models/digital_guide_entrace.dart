import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_entrace.freezed.dart";
part "digital_guide_entrace.g.dart";

@freezed
class DigitalGuideEntrace with _$DigitalGuideEntrace {
  const factory DigitalGuideEntrace({
    required int id,
    required DigitalGuideTranslationsEntrace translations,
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
