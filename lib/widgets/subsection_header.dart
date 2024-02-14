import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SubsectionHeader extends StatelessWidget {
  const SubsectionHeader({super.key, required this.title, this.actionTitle, this.onClick});

  final String title;
  final String? actionTitle;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24.0, top: 16.0, right: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: context.textTheme.headline),
            actionTitle != null ? TextButton(
                onPressed: onClick,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  "${actionTitle!} >",
                  style: context.textTheme.boldBodyOrange,
                )) : const SizedBox.shrink()

          ],
        ),
      ),
    );
  }
}