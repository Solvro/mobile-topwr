import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../../api_base_rest/shared_models/social_links_data.dart";

part "department_details.freezed.dart";
part "department_details.g.dart";
part "department_details.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DepartmentDetailsResponse with _$DepartmentDetailsResponse, _$DepartmentDetailsResponseTranslatable {
  const factory DepartmentDetailsResponse({@translatableField required DepartmentDetails data}) =
      _DepartmentDetailsResponse;
  const DepartmentDetailsResponse._();
  factory DepartmentDetailsResponse.fromJson(Map<String, dynamic> json) => _$DepartmentDetailsResponseFromJson(json);
}

@freezed
abstract class DepartmentDetails with _$DepartmentDetails {
  const factory DepartmentDetails({
    required int id,
    @translatableField required String name,
    required String code,
    required String betterCode,
    required String logoKey,
    required String gradientStart,
    required String gradientStop,
    required String addressLine1,
    required String addressLine2,
    required IList<FieldOfStudy> fieldsOfStudy,
    required IList<SocialLinksData> departmentLinks,
  }) = _DepartmentDetails;

  factory DepartmentDetails.fromJson(Map<String, dynamic> json) => _$DepartmentDetailsFromJson(json);
}

@freezed
abstract class FieldOfStudy with _$FieldOfStudy {
  const factory FieldOfStudy({
    required String name,
    required String url,
    required int semesterCount, // TODO(simon-the-shark): fix to new schema, #759
    required bool isEnglish,
    required bool is2ndDegree,
    required bool hasWeekendOption,
  }) = _FieldOfStudy;

  factory FieldOfStudy.fromJson(Map<String, dynamic> json) => _$FieldOfStudyFromJson(json);
}
