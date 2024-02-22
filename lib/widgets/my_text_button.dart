import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    this.onClick,
    required this.actionTitle,
  });

  final void Function()? onClick;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          actionTitle,
          style: context.textTheme.boldBodyOrange,
        ));
  }
}
