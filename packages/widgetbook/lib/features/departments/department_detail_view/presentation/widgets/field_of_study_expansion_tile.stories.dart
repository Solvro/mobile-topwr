import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/field_of_study_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "field_of_study_expansion_tile.stories.g.dart";

final _mockFieldsOfStudy = [
  const FieldOfStudy(
    name: "Informatyka stosowana",
    url: "https://wit.pwr.edu.pl/kandydaci/studia-i-stopnia/informatyka-stosowana",
    isEnglish: false,
    studiesType: StudiesType.firstDegree,
    hasWeekendOption: false,
  ),
  const FieldOfStudy(
    name: "Applied Computer Science",
    url: "https://wit.pwr.edu.pl/en/candidates/studies-in-english/applied-computer-science",
    isEnglish: true,
    studiesType: StudiesType.firstDegree,
    hasWeekendOption: false,
  ),
];

class FieldOfStudyExpansionTileStoryKnobs {
  final List<FieldOfStudy> fieldsOfStudy;
  final String title;
  final bool initiallyExpanded;
  FieldOfStudyExpansionTileStoryKnobs({
    required this.fieldsOfStudy,
    required this.title,
    required this.initiallyExpanded,
  });
}

const meta = MetaWithArgs<FieldOfStudyExpansionTile, FieldOfStudyExpansionTileStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => FieldOfStudyExpansionTile(
    fieldsOfStudy: args.fieldsOfStudy,
    title: args.title,
    initiallyExpanded: args.initiallyExpanded,
  ),
);

final $default = FieldOfStudyExpansionTileStory(
  args: FieldOfStudyExpansionTileStoryKnobsArgs(
    fieldsOfStudy: Arg.fixed(_mockFieldsOfStudy),
    title: Arg.fixed("Kierunki studiów"),
  ),
);
