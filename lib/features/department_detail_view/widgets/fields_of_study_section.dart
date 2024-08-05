import "package:flutter/cupertino.dart";
import "package:separate/separate.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/wide_tile_card.dart";

class FieldsOfStudySection extends StatelessWidget {
  const FieldsOfStudySection({super.key, required this.fieldsOfStudy});

  final List<String> fieldsOfStudy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localize.fields_of_study,
            style: context.textTheme.headline,
          ),
          const SizedBox(height: 16),
          ...fieldsOfStudy
              .map<Widget>(
                (item) => WideTileCard(title: item),
              )
              .separate(
                (i, e0, e1) => const SizedBox(height: 12),
              ),
        ],
      ),
    );
  }
}
