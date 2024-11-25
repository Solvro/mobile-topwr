import "package:flutter/material.dart";

import "../../theme/app_theme.dart";

class DetailViewPopButton extends StatelessWidget {
  const DetailViewPopButton(
    this.title, {
    super.key,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
      ),
      child: Text(
        title == null ? "<" : "< $title",
        style: context.textTheme.boldBodyOrange,
      ),
    );
  }
}
