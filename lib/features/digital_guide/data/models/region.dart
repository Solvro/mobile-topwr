import "package:freezed_annotation/freezed_annotation.dart";

part "region.freezed.dart";
part "region.g.dart";

@freezed
class Region with _$Region {
  const factory Region({
    required RegionTranslations translations,
    @JsonKey(name: "adapted_toilets") required List<int> adaptedToiletsIndices,
    @JsonKey(name: "rooms") required List<int> roomsIds,
    @JsonKey(name: "lifts") required List<int> liftsIds,
  }) = _Region;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}

@freezed
class RegionTranslations with _$RegionTranslations {
  const factory RegionTranslations({
    @JsonKey(name: "pl") required RegionTranslation plTranslation,
  }) = _RegionTranslations;

  factory RegionTranslations.fromJson(Map<String, dynamic> json) =>
      _$RegionTranslationsFromJson(json);
}

@freezed
class RegionTranslation with _$RegionTranslation {
  const factory RegionTranslation({
    required String name,
    required String location,
  }) = _RegionTranslation;

  factory RegionTranslation.fromJson(Map<String, dynamic> json) =>
      _$RegionTranslationFromJson(json);
}
