import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";

part "guide_data.freezed.dart";
part "guide_data.g.dart";
part "guide_data.translatable.g.dart";

@freezed
@translatable
abstract class GuideDataResponse with _$GuideDataResponse, _$GuideDataResponseTranslatable {
  const factory GuideDataResponse({required IList<GuideData> data}) = _GuideDataResponse;
  const GuideDataResponse._();
  factory GuideDataResponse.fromJson(Map<String, dynamic> json) => _$GuideDataResponseFromJson(json);
}

@freezed
abstract class GuideData with _$GuideData {
  const factory GuideData({
    required int id,
    required String title,
    required String shortDesc,
    required ImageData image,
  }) = _GuideData;

  factory GuideData.fromJson(Map<String, dynamic> json) => _$GuideDataFromJson(json);
}
