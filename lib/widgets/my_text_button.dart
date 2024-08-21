import "package:flutter/material.dart";

import "../theme/app_theme.dart";

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    this.onClick,
    required this.actionTitle,
  });

  final VoidCallback? onClick;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
      ),
      child: Text(
        actionTitle,
        style: onClick == null
            ? context.textTheme.boldBodyOrange.copyWith(
                color: context.colorTheme.greyPigeon,
              )
            : context.textTheme.boldBodyOrange,
      ),
    );
  }
}
