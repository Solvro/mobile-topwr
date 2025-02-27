import "package:freezed_annotation/freezed_annotation.dart";

import "../../tabs/information_points/models/digital_guide_information_points.dart";

part "optional_tiles_data.freezed.dart";

@freezed
class OptionalTilesData with _$OptionalTilesData {
  const factory OptionalTilesData({
    DigitalGuideInformationPoint? informationPoint,
  }) = _OptionalTilesData;
}
