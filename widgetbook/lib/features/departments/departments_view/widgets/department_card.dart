import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/departments/departments_view/data/models/department.dart";
import "package:topwr/features/departments/departments_view/widgets/department_card.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockDepartment = Department(
  id: 1,
  name: "Department of Computer Science",
  code: "CS",
  betterCode: "CS-2024",
  gradientStart: "#FF5733",
  gradientStop: "#33FF57",
  branch: Branch.main,
);

@widgetbook.UseCase(name: "default", type: DepartmentCard)
Widget useCaseDepartmentCard(BuildContext context) {
  return const DepartmentCard(_mockDepartment);
}
