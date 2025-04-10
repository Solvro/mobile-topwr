import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "department_link.dart";
import "field_of_study.dart";

part "detailed_department.freezed.dart";
part "detailed_department.g.dart";

@freezed
abstract class DetailedDepartment with _$DetailedDepartment {
  const factory DetailedDepartment({
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
    required IList<DepartmentLink> departmentLink,
  }) = _DetailedDepartment;

  factory DetailedDepartment.fromJson(Map<String, dynamic> json) => _$DetailedDepartmentFromJson(json);

  String get3LinesAddress() {
    final match = RegExp(r"^(.*)\s((ul\.|wyb\.|pl\.).*)").firstMatch(addressLine1);
    return match != null ? "${match.group(1)}\n${match.group(2)}\n$addressLine2" : "$addressLine1\n$addressLine2";
  }
}
