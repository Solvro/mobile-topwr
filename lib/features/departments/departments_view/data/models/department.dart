import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "department.freezed.dart";
part "department.g.dart";

@freezed
abstract class DepartmentsResponse with _$DepartmentsResponse {
  const factory DepartmentsResponse({required IList<Department> data}) = _DepartmentsResponse;

  factory DepartmentsResponse.fromJson(Map<String, dynamic> json) => _$DepartmentsResponseFromJson(json);
}

@freezed
abstract class Department with _$Department {
  const factory Department({
    required int id,
    required String name,
    required String code,
    required String betterCode,
    required String logoKey,
    required String gradientStart,
    required String gradientStop,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}
