import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class DetailsScreenAppBar extends AppBar {
  DetailsScreenAppBar(BuildContext context, {super.key, required String title})
      : super(
          centerTitle: false,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Text(
                '< $title',
                style: context.textTheme.boldBodyOrange,
              )),
        );
}
