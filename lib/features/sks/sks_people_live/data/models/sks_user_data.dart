import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../utils/datetime_utils.dart";

part "sks_user_data.freezed.dart";
part "sks_user_data.g.dart";

@freezed
abstract class SksUserData with _$SksUserData {
  const factory SksUserData({
    required int activeUsers,
    required int movingAverage21,
    @JsonKey(fromJson: fromJsonToLocalTime) required DateTime externalTimestamp,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Trend trend,
    required bool isResultRecent,
    required DateTime nextUpdateTimestamp,
  }) = _SksUserData;

  factory SksUserData.fromJson(Map<String, dynamic> json) => _$SksUserDataFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Trend { increasing, decreasing, stable }
