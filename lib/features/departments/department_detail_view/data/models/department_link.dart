import "package:freezed_annotation/freezed_annotation.dart";

part "department_link.freezed.dart";
part "department_link.g.dart";

@freezed
abstract class DepartmentLink with _$DepartmentLink {
  const factory DepartmentLink({required String link}) = _DepartmentLink;

  factory DepartmentLink.fromJson(Map<String, dynamic> json) => _$DepartmentLinkFromJson(json);
}
