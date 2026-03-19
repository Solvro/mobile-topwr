import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/field_of_study_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockFieldsOfStudy = [
  const FieldOfStudy(
    name: "Computer Science",
    url: "https://example.com/cs",
    isEnglish: false,
    studiesType: StudiesType.firstDegree,
    hasWeekendOption: false,
  ),
  const FieldOfStudy(
    name: "Computer Science (English)",
    url: "https://example.com/cs-en",
    isEnglish: true,
    studiesType: StudiesType.firstDegree,
    hasWeekendOption: false,
  ),
];

@widgetbook.UseCase(name: "default", type: FieldOfStudyExpansionTile)
Widget useCaseFieldOfStudyExpansionTile(BuildContext context) {
  return FieldOfStudyExpansionTile(
    fieldsOfStudy: context.knobs.object.dropdown(
      label: "Fields of study",
      options: [_mockFieldsOfStudy, _mockFieldsOfStudy.sublist(0, 1)],
    ),
    title: context.knobs.string(label: "Title", initialValue: "Fields of Study"),
    initiallyExpanded: context.knobs.boolean(label: "Initially expanded"),
  );
}
