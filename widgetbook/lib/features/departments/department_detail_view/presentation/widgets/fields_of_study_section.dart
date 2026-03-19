import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/fields_of_study_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockFieldsOfStudy = IList<FieldOfStudy>(const [
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
]);

@widgetbook.UseCase(name: "default", type: FieldsOfStudySection)
Widget useCaseFieldsOfStudySection(BuildContext context) {
  return FieldsOfStudySection(fieldsOfStudy: _mockFieldsOfStudy);
}
