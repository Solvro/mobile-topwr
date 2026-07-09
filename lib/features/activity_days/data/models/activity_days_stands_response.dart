import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";

part "activity_days_stands_response.freezed.dart";
part "activity_days_stands_response.g.dart";

@freezed
abstract class DasStandsListResponse with _$DasStandsListResponse {
  const factory DasStandsListResponse(IList<DasStand> data) = _DasStandsListResponse;

  factory DasStandsListResponse.fromJson(Map<String, dynamic> json) => _$DasStandsListResponseFromJson(json);
}

@freezed
abstract class DasStand with _$DasStand {
  const factory DasStand({
    required int id,
    required String number,
    required String name,
    String? description,
    int? floorId,
    ImageData? logo,
  }) = _DasStand;

  factory DasStand.fromJson(Map<String, dynamic> json) => _$DasStandFromJson(json);
}
