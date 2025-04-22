import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../api_base_rest/shared_models/social_links_data.dart";

part "about_us_data.freezed.dart";
part "about_us_data.g.dart";

@freezed
abstract class AboutUsDataResponse with _$AboutUsDataResponse {
  const factory AboutUsDataResponse({required AboutUsData data}) = _AboutUsDataResponse;
  factory AboutUsDataResponse.fromJson(Map<String, dynamic> json) => _$AboutUsDataResponseFromJson(json);
}

@freezed
abstract class AboutUsData with _$AboutUsData {
  const factory AboutUsData({
    @JsonKey(name: "aboutUs") required AboutUsDetails aboutUsDetails,
    @JsonKey(name: "solvroSocialLinks") required IList<SocialLinksData> socialLinks,
  }) = _AboutUsData;
  factory AboutUsData.fromJson(Map<String, dynamic> json) => _$AboutUsDataFromJson(json);
}

@freezed
abstract class AboutUsDetails with _$AboutUsDetails {
  const factory AboutUsDetails({required String description, required ImageData coverPhoto}) = _AboutUsDetails;
  factory AboutUsDetails.fromJson(Map<String, dynamic> json) => _$AboutUsDetailsFromJson(json);
}
