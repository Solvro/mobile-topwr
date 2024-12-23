import "package:flutter/material.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022",
                    style: context.textTheme.body,
                  ),
                  const SizedBox(
                    width: DigitalGuideConfig.paddingSmall,
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: context.textTheme.body,
                    ),
                  ),
                ],
              );
          }).toList(),
        ),
      ],
    ),);
  }
}
