import "package:flutter/material.dart";

import "../../theme/app_theme.dart";
import "pop_button.dart";

class DetailViewAppBar extends AppBar {
  DetailViewAppBar({super.key, super.actions, ({String text, BuildContext context})? title})
    : super(
        title: title != null ? Text(title.text, style: title.context.textTheme.headlineMedium) : null,
        leading: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 4), child: DetailViewPopButton()),
        ),
        leadingWidth: 140,
        centerTitle: true,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        titleSpacing: 4,
      );
}
