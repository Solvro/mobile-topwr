import "package:freezed_annotation/freezed_annotation.dart";

part "social_links_data.freezed.dart";
part "social_links_data.g.dart";

@freezed
abstract class SocialLinksData with _$SocialLinksData {
  const factory SocialLinksData({@JsonKey(name: "link") required String url}) = _SocialLinksData;
  factory SocialLinksData.fromJson(Map<String, dynamic> json) => _$SocialLinksDataFromJson(json);
}
