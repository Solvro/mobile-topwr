import "package:flutter/widgets.dart";
import "package:topwr/features/departments/departments_view/widgets/departments_view_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DepartmentsViewLoading)
Widget useCaseDepartmentsViewLoading(BuildContext context) {
  return const DepartmentsViewLoading();
}
