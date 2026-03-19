import "package:flutter/widgets.dart";
import "package:topwr/features/departments/departments_view/departments_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DepartmentsView)
Widget useCaseDepartmentsView(BuildContext context) {
  return const DepartmentsView();
}
