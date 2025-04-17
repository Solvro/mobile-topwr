import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "department_details.freezed.dart";
part "department_details.g.dart";

@freezed
abstract class DepartmentDetailsResponse with _$DepartmentDetailsResponse {
  const factory DepartmentDetailsResponse({required DepartmentDetails data}) = _DepartmentDetailsResponse;

  factory DepartmentDetailsResponse.fromJson(Map<String, dynamic> json) => _$DepartmentDetailsResponseFromJson(json);
}

@freezed
abstract class DepartmentDetails with _$DepartmentDetails {
  const factory DepartmentDetails({
    required int id,
    required String name,
    required String code,
    required String betterCode,
    required String logoKey,
    required String gradientStart,
    required String gradientStop,
    required String addressLine1,
    required String addressLine2,
    required IList<FieldOfStudy> fieldOfStudy,
    required IList<DepartmentLink> departmentLinks,
  }) = _DepartmentDetails;

  factory DepartmentDetails.fromJson(Map<String, dynamic> json) => _$DepartmentDetailsFromJson(json);
}

@freezed
abstract class FieldOfStudy with _$FieldOfStudy {
  const factory FieldOfStudy({
    required String name,
    required String url,
    required int semesterCount,
    required bool isEnglish,
    required bool is2ndDegree,
    required bool hasWeekendOption,
  }) = _FieldOfStudy;

  factory FieldOfStudy.fromJson(Map<String, dynamic> json) => _$FieldOfStudyFromJson(json);
}

@freezed
abstract class DepartmentLink with _$DepartmentLink {
  const factory DepartmentLink({required String link, required String name}) = _DepartmentLink;

  factory DepartmentLink.fromJson(Map<String, dynamic> json) => _$DepartmentLinkFromJson(json);
}
