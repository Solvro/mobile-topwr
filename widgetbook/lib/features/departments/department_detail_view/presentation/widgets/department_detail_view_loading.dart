import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/view_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DepartmentDetailViewLoading)
Widget useCaseDepartmentDetailViewLoading(BuildContext context) {
  return const DepartmentDetailViewLoading();
}
