import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_evacuation.freezed.dart";
part "digital_guide_evacuation.g.dart";

@freezed
class DigitalGuideEvacuation with _$DigitalGuideEvacuation {
  const factory DigitalGuideEvacuation({
    required String evacuationDescription,
    required String? evacuationMapUrl,
  }) = _DigitalGuideEvacuation;

  factory DigitalGuideEvacuation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideEvacuationFromJson(json);
}
