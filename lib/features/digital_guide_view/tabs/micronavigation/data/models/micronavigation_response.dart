// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "micronavigation_response.freezed.dart";
part "micronavigation_response.g.dart";

@freezed
class MicronavigationResponse with _$MicronavigationResponse {
  const factory MicronavigationResponse({
    required int id,
    required int location,
    @JsonKey(name: "name_override")
    required MicronavigationNameOverride nameOverride,
    @JsonKey(name: "web_content") required MicronavigationContent webContent,
    required int sn,
    required bool inside,
    required List<MicronavigationProfile> profiles,
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
class MicronavigationProfile with _$MicronavigationProfile {
  const factory MicronavigationProfile({
    required int id,
    required int profile,
    @JsonKey(name: "web_content") required MicronavigationContent webContent,
  }) = _MicronavigationProfile;

  factory MicronavigationProfile.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationProfileFromJson(json);
}

@freezed
class MicronavigationLanguage with _$MicronavigationLanguage {
  const factory MicronavigationLanguage({
    required int id,
    @JsonKey(name: "lang_code") required String langCode,
    String? text,
    String? sound,
    required int order,
  }) = _MicronavigationLanguage;

  factory MicronavigationLanguage.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationLanguageFromJson(json);
}
