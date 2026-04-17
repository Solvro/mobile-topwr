import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "sks_opening_hours.freezed.dart";
part "sks_opening_hours.g.dart";

@freezed
abstract class SksOpeningHoursResponse with _$SksOpeningHoursResponse {
  const factory SksOpeningHoursResponse({required IList<OpeningHours> data}) = _SksOpeningHoursResponse;

  factory SksOpeningHoursResponse.fromJson(Map<String, dynamic> json) => _$SksOpeningHoursResponseFromJson(json);
}

@freezed
abstract class OpeningHours with _$OpeningHours {
  const factory OpeningHours({required String language, required String canteen, required String cafe}) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => _$OpeningHoursFromJson(json);
}
