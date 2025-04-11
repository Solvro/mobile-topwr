import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
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
    @JsonKey(fromJson: fieldOfStudyFromJson) required IList<FieldOfStudy> fieldOfStudy,
    @JsonKey(fromJson: departmentLinksFromJson) required IList<DepartmentLink> departmentLink,
  }) = _DetailedDepartment;

  factory DetailedDepartment.fromJson(Map<String, dynamic> json) =>
      _$DetailedDepartmentFromJson(_jsonBulletProof(json));

  static Map<String, dynamic> _jsonBulletProof(Map<String, dynamic> json) {
    return (json.containsKey("data") && json["data"] is Map<String, dynamic>)
        ? json["data"] as Map<String, dynamic>
        : json;
  }
}

IList<FieldOfStudy> fieldOfStudyFromJson(List<dynamic> json) {
  return IList<FieldOfStudy>(json.map((element) => FieldOfStudy.fromJson(element as Map<String, dynamic>)).toList());
}

IList<DepartmentLink> departmentLinksFromJson(List<dynamic> json) {
  return IList<DepartmentLink>(
    json.map((element) => DepartmentLink.fromJson(element as Map<String, dynamic>)).toList(),
  );
}

extension AddressFormatterX on DetailedDepartment {
  String get address3lines {
    final match = RegExp(r"^(.*)\s((ul\.|wyb\.|pl\.).*)").firstMatch(addressLine1);
    return match != null ? "${match.group(1)}\n${match.group(2)}\n$addressLine2" : "$addressLine1\n$addressLine2";
  }
}
