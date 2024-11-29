import "package:flutter/widgets.dart";

import "../../../../config/ui_config.dart";

class HeadlinesSection extends StatelessWidget {
  const HeadlinesSection({
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BuildingDetailConfig.headlinesPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(description),
        ],
      ),
    );
  }
}
