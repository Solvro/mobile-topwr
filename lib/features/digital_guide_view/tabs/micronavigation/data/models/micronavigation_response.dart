// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "micronavigation_response.freezed.dart";
part "micronavigation_response.g.dart";

@freezed
class MicronavigationResponse with _$MicronavigationResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MicronavigationResponse({
    required int id,
    required int location,
    required MicronavigationNameOverride nameOverride,
    required MicronavigationContent webContent,
    required List<MicronavigationLanguage> languages,
  }) = _MicronavigationResponse;

  factory MicronavigationResponse.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationResponseFromJson(json);
}

@freezed
class MicronavigationNameOverride with _$MicronavigationNameOverride {
  const factory MicronavigationNameOverride({
    String? pl,
    String? en,
    String? nb,
    String? de,
    String? uk,
  }) = _MicronavigationNameOverride;

  factory MicronavigationNameOverride.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationNameOverrideFromJson(json);
}

@freezed
class MicronavigationContent with _$MicronavigationContent {
  const factory MicronavigationContent({
    String? pl,
    String? en,
    String? nb,
    String? de,
    String? uk,
  }) = _MicronavigationContent;

  factory MicronavigationContent.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationContentFromJson(json);
}

@freezed
class MicronavigationLanguage with _$MicronavigationLanguage {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MicronavigationLanguage({
    required int id,
    required String langCode,
    String? text,
    String? sound,
    required int order,
  }) = _MicronavigationLanguage;

  factory MicronavigationLanguage.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationLanguageFromJson(json);
}
