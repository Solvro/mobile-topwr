import "package:test/test.dart";

import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/departments/departments_view/data/models/department.dart";
import "package:topwr/features/departments/departments_view/data/repository/departments_repository.dart";

void main() {
  const departmentMainTwo = Department(
    id: 1,
    name: "Department W2",
    code: "W2",
    betterCode: "W-2",
    logo: null,
    gradientStart: "000000",
    gradientStop: "FFFFFF",
    branch: Branch.main,
  );
  const departmentMainTen = Department(
    id: 2,
    name: "Department W10",
    code: "W10",
    betterCode: "W-10",
    logo: null,
    gradientStart: "000000",
    gradientStop: "FFFFFF",
    branch: Branch.main,
  );
  const departmentOtherThree = Department(
    id: 3,
    name: "Department Z3",
    code: "Z3",
    betterCode: "Z-3",
    logo: null,
    gradientStart: "000000",
    gradientStop: "FFFFFF",
    branch: Branch.walbrzych,
  );
  const departmentOtherOne = Department(
    id: 4,
    name: "Department Z1",
    code: "Z1",
    betterCode: "Z-1",
    logo: null,
    gradientStart: "000000",
    gradientStop: "FFFFFF",
    branch: Branch.walbrzych,
  );

  test("sortByBranch groups selected branch first and sorts by code", () {
    final departments = [
      departmentOtherThree,
      departmentMainTen,
      departmentOtherOne,
      departmentMainTwo,
    ];

    final sorted = departments.sortByBranch(Branch.main);

    expect(sorted.map((department) => department.code).toList(), ["W2", "W10", "Z1", "Z3"]);
  });
}
