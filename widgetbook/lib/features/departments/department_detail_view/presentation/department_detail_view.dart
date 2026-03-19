import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/presentation/department_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DepartmentDetailView)
Widget useCaseDepartmentDetailView(BuildContext context) {
  return const DepartmentDetailView(id: 1);
}
