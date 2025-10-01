import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../branches/model/branch.dart";

part "department.freezed.dart";
part "department.g.dart";
part "department.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DepartmentsResponse with _$DepartmentsResponse, _$DepartmentsResponseTranslatable {
  const factory DepartmentsResponse({@translatableField required IList<Department> data}) = _DepartmentsResponse;
  const DepartmentsResponse._();
  factory DepartmentsResponse.fromJson(Map<String, dynamic> json) => _$DepartmentsResponseFromJson(json);
}

@freezed
abstract class Department with _$Department {
  const factory Department({
    required int id,
    @translatableField required String name,
    required String code,
    required String betterCode,
    required String logoKey,
    required String gradientStart,
    required String gradientStop,
    required Branch branch,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}
