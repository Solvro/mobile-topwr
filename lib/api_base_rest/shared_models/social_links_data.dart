import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "social_links_data.freezed.dart";
part "social_links_data.g.dart";

@freezed
abstract class SocialLinksData with _$SocialLinksData {
  const factory SocialLinksData({@JsonKey(name: "link") @nonTranslatableField required String url, String? name}) =
      _SocialLinksData;
  factory SocialLinksData.fromJson(Map<String, dynamic> json) => _$SocialLinksDataFromJson(json);
}
