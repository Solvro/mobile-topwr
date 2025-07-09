import "package:flutter/material.dart";

import "../theme/app_theme.dart";

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, this.onClick, required this.actionTitle, this.showBorder = false, this.color});

  final VoidCallback? onClick;
  final String actionTitle;
  final bool showBorder;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
        side: showBorder ? BorderSide(color: color ?? context.colorTheme.orangePomegranade) : null,
      ),
      child: Text(
        actionTitle,
        style: onClick == null
            ? context.textTheme.boldBodyOrange.copyWith(color: color ?? context.colorTheme.greyPigeon)
            : context.textTheme.boldBodyOrange.copyWith(color: color ?? context.colorTheme.orangePomegranade),
      ),
    );
  }
}
