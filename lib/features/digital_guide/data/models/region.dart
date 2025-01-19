import "package:freezed_annotation/freezed_annotation.dart";

part "region.freezed.dart";
part "region.g.dart";

@freezed
class Region with _$Region {
  const factory Region({
    required RegionTranslations translations,
    @JsonKey(name: "dressing_rooms") required List<int> dressingRoomIndices,
    @JsonKey(name: "lodges") required List<int> lodgesIndices,
    @JsonKey(name: "information_points") required List<int> informationPointsIndices,
    @JsonKey(name: "toilets") required List<int>toiletsIndices,
    @JsonKey(name: "adapted_toilets") required List<int> adaptedToiletsIndices,
     @JsonKey(name: "lifts") required List<int> liftsIndices,
    @JsonKey(name: "stairs") required List<int> stairsIndices,
    @JsonKey(name: "ramps") required List<int> rampsIndices,
    @JsonKey(name: "corridors") required List<int> corridorsIndices,
    @JsonKey(name: "stairways") required List<int> stwairwaysIndices,
    @JsonKey(name: "rooms") required List<int> roomsIds,
    @JsonKey(name: "parkings") required List<int> parkingsIndices,
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
