import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_response.freezed.dart";
part "digital_guide_response.g.dart";

@freezed
class DigitalGuideResponse with _$DigitalGuideResponse {

  const factory DigitalGuideResponse({
    required int id,
    required String telephone_number,
  }) = _DigitalGuideResponse;

  factory DigitalGuideResponse.fromJson(Map<String,dynamic> json) =>
    _$DigitalGuideResponseFromJson(json);
  
}
