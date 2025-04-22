import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "versions_data.freezed.dart";
part "versions_data.g.dart";

@freezed
abstract class VersionsDataResponse with _$VersionsDataResponse {
  const factory VersionsDataResponse({required IList<VersionsData> data}) = _VersionsDataResponse;
  factory VersionsDataResponse.fromJson(Map<String, dynamic> json) => _$VersionsDataResponseFromJson(json);
}

@freezed
abstract class VersionsData with _$VersionsData {
  const factory VersionsData({required String name, required int milestoneId}) = _VersionsData;
  factory VersionsData.fromJson(Map<String, dynamic> json) => _$VersionsDataFromJson(json);
}
