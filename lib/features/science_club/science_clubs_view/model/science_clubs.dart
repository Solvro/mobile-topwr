import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "science_clubs.freezed.dart";
part "science_clubs.g.dart";

@freezed
abstract class ScienceClub with _$ScienceClub {
  const factory ScienceClub({
    required int id,
    required String name,
    required String organizationStatus,
    required String source,
    required String organizationType,
    required bool coverPreview,
    IList<TagsData>? tags,
    LogoData? logo,
    CoverData? cover,
    String? shortDescription,
    int? departmentId,
    String? departmentName,
    String? code,
    String? betterCode,
  }) = _ScienceClub;

  factory ScienceClub.fromJson(Map<String, dynamic> json) => _$ScienceClubFromJson(json);
}

@freezed
abstract class ScienceClubsResponse with _$ScienceClubsResponse {
  const factory ScienceClubsResponse({required IList<ScienceClub> data}) = _ScienceClubsResponse;

  factory ScienceClubsResponse.fromJson(Map<String, dynamic> json) => _$ScienceClubsResponseFromJson(json);
}

@freezed
abstract class DepartmentsResponse with _$DepartmentsResponse {
  const factory DepartmentsResponse({required IList<Department> data}) = _DepartmentsResponse;
  factory DepartmentsResponse.fromJson(Map<String, dynamic> json) => _$DepartmentsResponseFromJson(json);
}

@freezed
abstract class Department with _$Department {
  const factory Department({required int id, required String name, required String code, required String betterCode}) =
      _Department;

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}

@freezed
abstract class TagsData with _$TagsData {
  const factory TagsData({required String tag}) = _TagsData;

  factory TagsData.fromJson(Map<String, dynamic> json) => _$TagsDataFromJson(json);
}

@freezed
abstract class LogoData with _$LogoData {
  const factory LogoData({required String id, required String url}) = _LogoData;

  factory LogoData.fromJson(Map<String, dynamic> json) => _$LogoDataFromJson(json);
}

@freezed
abstract class CoverData with _$CoverData {
  const factory CoverData({required String id, required String url}) = _CoverData;

  factory CoverData.fromJson(Map<String, dynamic> json) => _$CoverDataFromJson(json);
}
