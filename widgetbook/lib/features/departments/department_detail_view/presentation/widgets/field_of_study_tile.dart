import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/field_of_study_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockFieldOfStudy = FieldOfStudy(
  name: "Computer Science",
  url: "https://example.com/cs",
  isEnglish: false,
  studiesType: StudiesType.firstDegree,
  hasWeekendOption: false,
);

@widgetbook.UseCase(name: "default", type: FieldOfStudyTile)
Widget useCaseFieldOfStudyTile(BuildContext context) {
  return const FieldOfStudyTile(_mockFieldOfStudy);
}
