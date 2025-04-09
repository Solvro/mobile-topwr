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
    required String logo,
    required String gradientStart,
    required String gradientEnd,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}
