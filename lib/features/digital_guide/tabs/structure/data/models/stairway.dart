import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "stairway.g.dart";
part "stairway.freezed.dart";

@freezed
class Stairway with _$Stairway {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Stairway({
    required StairwayTranslations translations,
    required String areObjectsNarrowCommunicationZone,
    required String areInformationBoards,
    required String areInformationBoardsInEn,
    required String areRoomEntrances,
    required String areFloorMarkings,
    required String isTyphlomap,
    @JsonKey(name: "doors") required IList<int> doorsIds,
    @JsonKey(name: "lifts") required IList<int> liftsIds,
    @JsonKey(name: "stairs") required IList<int> stairsIds,
    @JsonKey(name: "images") required IList<int> imagesIds,
  }) = _Stairway;

  factory Stairway.fromJson(Map<String, dynamic> json) =>
      _$StairwayFromJson(json);
}

@freezed
class StairwayTranslations with _$StairwayTranslations {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StairwayTranslations({
    @JsonKey(name: "pl") required StairwayTranslation plTranslation,
  }) = _StairwayTranslations;

  factory StairwayTranslations.fromJson(Map<String, dynamic> json) =>
      _$StairwayTranslationsFromJson(json);
}

@freezed
class StairwayTranslation with _$StairwayTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StairwayTranslation({
    required String name,
    required String location,
    required String areObjectsNarrowCommunicationZoneComment,
    required String areInformationBoardsComment,
    required String areInformationBoardsInEnComment,
    required String areRoomEntrancesComment,
    required String areFloorMarkingsComment,
    required String isTyphlomapComment,
    required String comment,
  }) = _StairwayTranslation;

  factory StairwayTranslation.fromJson(Map<String, dynamic> json) =>
      _$StairwayTranslationFromJson(json);
}
