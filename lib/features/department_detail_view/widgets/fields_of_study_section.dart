import "package:flutter/cupertino.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../repository/getDepartmentDetails.graphql.dart";
import "field_of_study_expansion_tile.dart";

typedef FieldOfStudy
    = Query$GetDepartmentDetails$Departments_by_id$fieldsOfStudies;

class FieldsOfStudySection extends StatelessWidget {
  const FieldsOfStudySection({super.key, required this.fieldsOfStudy});

  final List<FieldOfStudy> fieldsOfStudy;

  @override
  Widget build(BuildContext context) {
    final firstDegree = fieldsOfStudy
        .where((item) => !item.is2ndDegree && !item.isLongCycleStudies);
    final secondDegree = fieldsOfStudy
        .where((item) => item.is2ndDegree && !item.isLongCycleStudies);
    final longCycle = fieldsOfStudy.where((item) => item.isLongCycleStudies);

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localize.fields_of_study,
            style: context.textTheme.headline,
          ),
          if (firstDegree.isNotEmpty)
            FieldOfStudyExpansionTile(
              title: context.localize.first_degree,
              fieldsOfStudy: firstDegree,
              initiallyExpanded: true,
            ),
          if (secondDegree.isNotEmpty)
            FieldOfStudyExpansionTile(
              title: context.localize.second_degree,
              fieldsOfStudy: secondDegree,
            ),
          if (longCycle.isNotEmpty)
            FieldOfStudyExpansionTile(
              title: context.localize.long_cycle,
              fieldsOfStudy: longCycle,
              initiallyExpanded: true,
            ),
        ],
      ),
    );
  }
}
