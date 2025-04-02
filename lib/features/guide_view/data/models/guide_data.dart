import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "guide_data.freezed.dart";
part "guide_data.g.dart";

@freezed
abstract class GuideDataResponse with _$GuideDataResponse {
  const factory GuideDataResponse({required IList<GuideData> data}) = _GuideDataResponse;
  factory GuideDataResponse.fromJson(Map<String, dynamic> json) => _$GuideDataResponseFromJson(json);
}

@freezed
abstract class GuideData with _$GuideData {
  const factory GuideData({
    required int id,
    required String title,
    required String shortDesc,
    required String imagePath,
  }) = _GuideData;

  factory GuideData.fromJson(Map<String, dynamic> json) => _$GuideDataFromJson(json);
}
