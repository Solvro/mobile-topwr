// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_response.freezed.dart";
part "digital_guide_response.g.dart";

@freezed
class DigitalGuideResponse with _$DigitalGuideResponse {
  const factory DigitalGuideResponse({
    required int id,
    required DigitalGuideTranslations translations,
    @JsonKey(name: "number_of_storeys") required int numberOfStoreys,
    @JsonKey(name: "telephone_number") required String telephoneNumber,
    required List<int> images,
  }) = _DigitalGuideResponse;

  factory DigitalGuideResponse.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideResponseFromJson(json);
}

@freezed
class DigitalGuideTranslations with _$DigitalGuideTranslations {
  const factory DigitalGuideTranslations({
    required DigitalGuideTranslation pl,
  }) = _DigitalGuideTranslations;

  factory DigitalGuideTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsFromJson(json);
}

@freezed
class DigitalGuideTranslation with _$DigitalGuideTranslation {
  const factory DigitalGuideTranslation({
    required String name,
    @JsonKey(name: "extended_name") required String extendedName,
    required String address,
  }) = _DigitalGuideTranslation;

  factory DigitalGuideTranslation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationFromJson(json);
}
