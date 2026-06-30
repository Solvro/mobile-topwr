import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/field_of_study_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "field_of_study_tile.stories.g.dart";

const _mockFieldOfStudy = FieldOfStudy(
  name: "Informatyka stosowana",
  url: "https://wit.pwr.edu.pl/kandydaci/studia-i-stopnia/informatyka-stosowana",
  isEnglish: false,
  studiesType: StudiesType.firstDegree,
  hasWeekendOption: false,
);

const meta = Meta(FieldOfStudyTile.new);

final $default = FieldOfStudyTileStory(args: FieldOfStudyTileArgs(item: Arg.fixed(_mockFieldOfStudy)));
