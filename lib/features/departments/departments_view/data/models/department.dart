import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "department.freezed.dart";
part "department.g.dart";

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

  static IList<Department> fromJsonList(Map<String, dynamic> json) {
    return (json["data"] as List<dynamic>)
        .map((departmentJson) => Department.fromJson(departmentJson as Map<String, dynamic>))
        .toList()
        .lock;
  }

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}
