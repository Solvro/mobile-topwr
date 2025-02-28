import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../../theme/app_theme.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "field_of_study_tile.dart";
import "fields_of_study_section.dart";

class FieldOfStudyExpansionTile extends StatelessWidget {
  const FieldOfStudyExpansionTile({
    super.key,
    required this.fieldsOfStudy,
    required this.title,
    this.initiallyExpanded = false,
  });
  final Iterable<FieldOfStudy> fieldsOfStudy;
  final String title;
  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: MyExpansionTile(
        backgroundColor: context.colorTheme.whiteSoap,
        initiallyExpanded: initiallyExpanded,
        title: title,
        children:
            fieldsOfStudy
                .map<Widget>(FieldOfStudyTile.new)
                .separate((i, e0, e1) => const SizedBox(height: 12))
                .toList(),
      ),
    );
  }
}
