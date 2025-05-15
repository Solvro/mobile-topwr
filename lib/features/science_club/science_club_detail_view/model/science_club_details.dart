import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "science_club_details.freezed.dart";
part "science_club_details.g.dart";

@freezed
abstract class ScienceClubDetails with _$ScienceClubDetails {
  const factory ScienceClubDetails({
    required String name,
    required String source,
    required bool isStrategic,
    String? description,
    CoverData? cover,
    IList<LinksData>? links,
    LogoData? logo,
    Department? department,
  }) = _ScienceClubDetails;

  factory ScienceClubDetails.fromJson(Map<String, dynamic> json) => _$ScienceClubDetailsFromJson(json);
}

@freezed
abstract class ClubDetailsResponse with _$ClubDetailsResponse {
  const factory ClubDetailsResponse({required ScienceClubDetails data}) = _ClubDetailsResponse;

  factory ClubDetailsResponse.fromJson(Map<String, dynamic> json) => _$ClubDetailsResponseFromJson(json);
}

@freezed
abstract class Department with _$Department {
  const factory Department({required int id, required String name, required String code, required String betterCode}) =
      _Department;

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}

@freezed
abstract class CoverData with _$CoverData {
  const factory CoverData({required String id, required String url}) = _CoverData;

  factory CoverData.fromJson(Map<String, dynamic> json) => _$CoverDataFromJson(json);
}

@freezed
abstract class LinksData with _$LinksData {
  const factory LinksData({required int id, required int studentOrganizationId, required String link}) = _LinksData;

  factory LinksData.fromJson(Map<String, dynamic> json) => _$LinksDataFromJson(json);
}

@freezed
abstract class LogoData with _$LogoData {
  const factory LogoData({required String id, required String url}) = _LogoData;

  factory LogoData.fromJson(Map<String, dynamic> json) => _$LogoDataFromJson(json);
}
