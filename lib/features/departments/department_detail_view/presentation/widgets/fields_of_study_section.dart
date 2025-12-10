import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../data/models/department_details.dart";
import "../../data/utils/department_details_extension.dart";
import "field_of_study_expansion_tile.dart";

class FieldsOfStudySection extends StatelessWidget {
  const FieldsOfStudySection({super.key, required this.fieldsOfStudy});

  final IList<FieldOfStudy> fieldsOfStudy;

  @override
  Widget build(BuildContext context) {
    final firstDegree = fieldsOfStudy.whereFirstDegree;
    final secondDegree = fieldsOfStudy.whereSecondDegree;
    final longCycle = fieldsOfStudy.whereLongCycle;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize.fields_of_study, style: context.textTheme.headlineMedium),
          if (firstDegree.isNotEmpty)
            FieldOfStudyExpansionTile(
              title: context.localize.first_degree,
              fieldsOfStudy: firstDegree,
              initiallyExpanded: true,
            ),
          if (secondDegree.isNotEmpty)
            FieldOfStudyExpansionTile(title: context.localize.second_degree, fieldsOfStudy: secondDegree),
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
