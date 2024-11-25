import "package:flutter/material.dart";

import "../../theme/app_theme.dart";

class DetailViewAppBar extends AppBar {
  DetailViewAppBar(
    BuildContext context, {
    super.key,
    required String title,
    super.actions,
  }) : super(
          centerTitle: false,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          titleSpacing: 4,
          title: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
            ),
            child: Text(
              "< $title",
              style: context.textTheme.boldBodyOrange,
            ),
          ),
        );
}
