import "package:freezed_annotation/freezed_annotation.dart";

part "sks_opening_hours.freezed.dart";
part "sks_opening_hours.g.dart";

@freezed
abstract class SksOpeningHours with _$SksOpeningHours {
  const factory SksOpeningHours({required OpeningHours openingHours}) = _SksOpeningHours;

  factory SksOpeningHours.fromJson(Map<String, dynamic> json) => _$SksOpeningHoursFromJson(json);
}

@freezed
abstract class OpeningHours with _$OpeningHours {
  const factory OpeningHours({required VenueHours canteen, required VenueHours cafe}) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => _$OpeningHoursFromJson(json);
}

@freezed
abstract class VenueHours with _$VenueHours {
  const factory VenueHours({required String openingTime, required String closingTime}) = _VenueHours;

  factory VenueHours.fromJson(Map<String, dynamic> json) => _$VenueHoursFromJson(json);
}
