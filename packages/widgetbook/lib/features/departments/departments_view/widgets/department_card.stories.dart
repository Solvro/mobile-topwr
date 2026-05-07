import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/departments/departments_view/data/models/department.dart";
import "package:topwr/features/departments/departments_view/widgets/department_card.dart";
import "package:widgetbook/widgetbook.dart";

part "department_card.stories.g.dart";

const _mockDepartment = Department(
  id: 1,
  name: "Department of Computer Science",
  code: "CS",
  betterCode: "CS-2024",
  gradientStart: "#FF5733",
  gradientStop: "#33FF57",
  branch: Branch.main,
);

const meta = Meta<DepartmentCard>();

final $default = DepartmentCardStory(args: DepartmentCardArgs(department: Arg.fixed(_mockDepartment)));
