import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../services/translations_service/widgets/rich_text_with_translation.dart";

class BulletList extends StatelessWidget {
  final IList<String> items;

  const BulletList({super.key, required this.items, this.fontSize = 13});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final nonEmptyItems = items.where((item) => item.trim().isNotEmpty).toIList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: nonEmptyItems.length,
      itemBuilder: (context, index) {
        final item = nonEmptyItems[index];
        return RichTextWithTranslation(
          text: TextSpan(
            children: [
              TextSpan(text: "\u2022 ", style: context.textTheme.body.copyWith(fontSize: fontSize + 3)),
              TextSpan(text: item, style: context.textTheme.body.copyWith(fontSize: fontSize)),
            ],
          ),
        );
      },
    );
  }
}
