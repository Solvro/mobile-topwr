import "package:flutter/material.dart";

import "../theme/app_theme.dart";
import "my_text_button.dart";

class SubsectionHeader extends StatelessWidget {
  const SubsectionHeader({
    super.key,
    required this.title,
    this.actionTitle,
    this.onClick,
    this.leftPadding = 24,
    this.rightPadding = 12,
    this.addArrow = true,
  });

  final String title;
  final String? actionTitle;
  final VoidCallback? onClick;
  final double leftPadding;
  final double rightPadding;
  final bool addArrow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: 16, right: rightPadding),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 12,
          children: [
            Text(title, style: context.textTheme.headline),
            if (actionTitle != null)
              MyTextButton(onClick: onClick, actionTitle: addArrow ? "$actionTitle >" : actionTitle ?? ""),
          ],
        ),
      ),
    );
  }
}
