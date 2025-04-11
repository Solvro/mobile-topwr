import "package:freezed_annotation/freezed_annotation.dart";

part "department_link.freezed.dart";
part "department_link.g.dart";

@freezed
abstract class DepartmentLink with _$DepartmentLink {
  // TODO(24bartixx): once it's done from the backend side include String name
  const factory DepartmentLink({required String link}) = _DepartmentLink;

  factory DepartmentLink.fromJson(Map<String, dynamic> json) => _$DepartmentLinkFromJson(json);
}
