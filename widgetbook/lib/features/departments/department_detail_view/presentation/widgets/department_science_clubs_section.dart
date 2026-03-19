import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/science_clubs_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockDepartment = DepartmentDetails(
  id: 1,
  name: "Department of Computer Science",
  code: "CS",
  betterCode: "CS-2024",
  logo: null,
  gradientStart: "#FF5733",
  gradientStop: "#33FF57",
  addressLine1: "123 Main Street",
  addressLine2: "Building A",
  fieldsOfStudy: IList(const [
    FieldOfStudy(
      name: "Computer Science",
      url: "https://example.com/cs",
      isEnglish: false,
      studiesType: StudiesType.firstDegree,
      hasWeekendOption: false,
    ),
    FieldOfStudy(
      name: "Data Science",
      url: "https://example.com/ds",
      isEnglish: true,
      studiesType: StudiesType.secondDegree,
      hasWeekendOption: true,
    ),
  ]),
  departmentLinks: IList(const []),
);

@widgetbook.UseCase(name: "default", type: DepartmentScienceClubsSection)
Widget useCaseDepartmentScienceClubsSection(BuildContext context) {
  return DepartmentScienceClubsSection(_mockDepartment);
}
