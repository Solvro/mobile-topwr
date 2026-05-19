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
  const departmentMainA = Department(
    id: 5,
    name: "Department A1",
    code: "A1",
    betterCode: "A-1",
    logo: null,
    gradientStart: "000000",
    gradientStop: "FFFFFF",
    branch: Branch.main,
  );
  const departmentMainB = Department(
    id: 6,
    name: "Department B1",
    code: "B1",
    betterCode: "B-1",
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
  const departmentOtherWThree = Department(
    id: 7,
    name: "Department W3",
    code: "W3",
    betterCode: "W-3",
    logo: null,
    gradientStart: "000000",
    gradientStop: "FFFFFF",
    branch: Branch.walbrzych,
  );
  const departmentOtherB = Department(
    id: 8,
    name: "Department B2",
    code: "B2",
    betterCode: "B-2",
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

  test("sortByBranch groups selected branch first and sorts W codes before non-W codes", () {
    final departments = [
      departmentOtherB,
      departmentOtherThree,
      departmentMainA,
      departmentMainTen,
      departmentOtherOne,
      departmentMainTwo,
      departmentOtherWThree,
      departmentMainB,
    ];

    final sorted = departments.sortByBranch(Branch.main);

    expect(
      sorted.map((department) => department.code).toList(),
      ["W2", "W10", "A1", "B1", "W3", "B2", "Z1", "Z3"],
    );
  });

  test("sortByBranch sorts non-W codes alphabetically inside each branch group", () {
    final departments = [
      departmentOtherThree,
      departmentOtherB,
      departmentMainB,
      departmentMainA,
    ];

    final sorted = departments.sortByBranch(Branch.main);

    expect(sorted.map((department) => department.code).toList(), ["A1", "B1", "B2", "Z3"]);
  });
}
