import "package:freezed_annotation/freezed_annotation.dart";

part "sks_user_data.freezed.dart";
part "sks_user_data.g.dart";

@freezed
class SksUserData with _$SksUserData {
  const factory SksUserData({
    required int id,
    required int activeUsers,
    required int movingAverage21,
    required DateTime externalTimestamp,
    required DateTime createdAt,
    required DateTime updatedAt,
    @TrendConverter() required Trend trend,
  }) = _SksUserData;

  factory SksUserData.fromJson(Map<String, dynamic> json) =>
      _$SksUserDataFromJson(json);
}

enum Trend {
  increasing,
  decreasing,
  stable,
}

class TrendConverter implements JsonConverter<Trend, String> {
  const TrendConverter();

  @override
  Trend fromJson(String json) {
    switch (json.toUpperCase()) {
      case "INCREASING":
        return Trend.increasing;
      case "DECREASING":
        return Trend.decreasing;
      case "STABLE":
        return Trend.stable;
      default:
        throw ArgumentError("Unknown Trend value: $json");
    }
  }

  @override
  String toJson(Trend trend) {
    return trend.name.toUpperCase();
  }
}
