import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "tags.freezed.dart";
part "tags.g.dart";

@freezed
abstract class ScienceClub with _$ScienceClub {
  const factory ScienceClub({required int id, IList<Tag>? tags}) = _ScienceClub;
  factory ScienceClub.fromJson(Map<String, dynamic> json) => _$ScienceClubFromJson(json);
}

@freezed
abstract class ScienceClubsResponse with _$ScienceClubsResponse {
  const factory ScienceClubsResponse({required IList<ScienceClub> data}) = _ScienceClubsResponse;
  factory ScienceClubsResponse.fromJson(Map<String, dynamic> json) => _$ScienceClubsResponseFromJson(json);
}

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String tag}) = _Tag;
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
