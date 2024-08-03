import "package:flutter/material.dart";

import "../theme/app_theme.dart";
import "my_text_button.dart";

class SubsectionHeader extends StatelessWidget {
  const SubsectionHeader({
    super.key,
    required this.title,
    this.actionTitle,
    this.onClick,
  });

  final String title;
  final String? actionTitle;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.headline),
            if (actionTitle != null)
              MyTextButton(onClick: onClick, actionTitle: "$actionTitle >"),
          ],
        ),
      ),
    );
  }
}
