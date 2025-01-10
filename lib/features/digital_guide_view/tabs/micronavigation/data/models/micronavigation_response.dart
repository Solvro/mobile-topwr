// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "micronavigation_response.freezed.dart";
part "micronavigation_response.g.dart";

@freezed
class MicronavigationResponse with _$MicronavigationResponse {
  const factory MicronavigationResponse({
    required int id,
    required int location,
    @JsonKey(name: "range_entry_action") required String rangeEntryAction,
    @JsonKey(name: "user_triggered_action") required String userTriggeredAction,
    @JsonKey(name: "name_override")
    required MicronavigationNameOverride nameOverride,
    @JsonKey(name: "web_content") required MicronavigationContent webContent,
    @JsonKey(name: "rssi_detect_level") required int rssiDetectLevel,
    @JsonKey(name: "beep_length") required int beepLength,
    @JsonKey(name: "flash_beep_sound") required String flashBeepSound,
    required int volume,
    @JsonKey(name: "ibeacon_uuid") required String ibeaconUuid,
    @JsonKey(name: "ibeacon_major") required int ibeaconMajor,
    @JsonKey(name: "ibeacon_minor") required int ibeaconMinor,
    required int sn,
    @JsonKey(name: "needs_flashing") required bool needsFlashing,
    @JsonKey(name: "lang_info_from_device") required bool langInfoFromDevice,
    required bool active,
    @JsonKey(name: "show_on_web_site") required bool showOnWebSite,
    @JsonKey(name: "map_lat") required double mapLat,
    @JsonKey(name: "map_lon") required double mapLon,
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
    @JsonKey(name: "range_entry_action") String? rangeEntryAction,
    @JsonKey(name: "user_triggered_action") String? userTriggeredAction,
    int? volume,
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
