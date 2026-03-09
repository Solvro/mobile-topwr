import "package:freezed_annotation/freezed_annotation.dart";

part "parking_info.freezed.dart";
part "parking_info.g.dart";

@freezed
abstract class ParkingInfo with _$ParkingInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ParkingInfo({required String info}) = _ParkingInfo;

  factory ParkingInfo.fromJson(Map<String, dynamic> json) => _$ParkingInfoFromJson(json);
}
