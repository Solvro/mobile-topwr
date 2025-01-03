import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";

class BulletList extends StatelessWidget {
  final IList<String> items;

  const BulletList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
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
      },
    );
  }
}
