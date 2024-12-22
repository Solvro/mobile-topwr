// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "surrounding_response.freezed.dart";
part "surrounding_response.g.dart";

@freezed
class SurroundingResponse with _$SurroundingResponse {
  const factory SurroundingResponse({
    required SurroundingResponseTranslations translations,
  }) = _SurroundingResponse;

  factory SurroundingResponse.fromJson(Map<String, dynamic> json) =>
      _$SurroundingResponseFromJson(json);
}

@freezed
class SurroundingResponseTranslations with _$SurroundingResponseTranslations {
  const factory SurroundingResponseTranslations({
    @JsonKey(name: "pl") required SurroundingResponseTranslation translationPl,
  }) = _SurroundingResponseTranslations;

  factory SurroundingResponseTranslations.fromJson(Map<String, dynamic> json) =>
      _$SurroundingResponseTranslationsFromJson(json);
}

@freezed
class SurroundingResponseTranslation with _$SurroundingResponseTranslation {
  const factory SurroundingResponseTranslation({
    @JsonKey(name: "are_parking_spaces_comment")
    required String parkingSpacesComment,
  }) = _SurroundingResponseTranslation;

  factory SurroundingResponseTranslation.fromJson(Map<String, dynamic> json) =>
      _$SurroundingResponseTranslationFromJson(json);
}
