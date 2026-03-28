import "package:freezed_annotation/freezed_annotation.dart";

part "sks_opening_hours.freezed.dart";
part "sks_opening_hours.g.dart";

@freezed
abstract class SksOpeningHours with _$SksOpeningHours {
  const factory SksOpeningHours({required OpeningHours openingHours}) = _SksOpeningHours;

  factory SksOpeningHours.fromJson(Map<String, dynamic> json) {
    final data = (json["data"] as List<dynamic>).first as Map<String, dynamic>;
    return SksOpeningHours(openingHours: OpeningHours.fromJson(data));
  }
}

@freezed
abstract class OpeningHours with _$OpeningHours {
  const factory OpeningHours({required String canteen, required String cafe}) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => _$OpeningHoursFromJson(json);
}
