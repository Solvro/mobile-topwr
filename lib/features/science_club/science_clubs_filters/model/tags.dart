import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "tags.freezed.dart";
part "tags.g.dart";

@freezed
abstract class StudentClubs with _$StudentClubs {
  const factory StudentClubs({required int id, required IList<Tag> tags}) = _StudentClubs;

  factory StudentClubs.fromJson(Map<String, dynamic> json) => _$StudentClubsFromJson(json);
}

@freezed
abstract class StudentClubsResponse with _$StudentClubsResponse {
  const factory StudentClubsResponse({required StudentClubs data}) = _StudentClubsResponse;
  factory StudentClubsResponse.fromJson(Map<String, dynamic> json) => _$StudentClubsResponseFromJson(json);
}

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String tag}) = _Tag;
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
