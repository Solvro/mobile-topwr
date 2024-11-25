import "package:flutter/material.dart";

import "pop_button.dart";

class DetailViewAppBar extends AppBar {
  DetailViewAppBar({
    super.key,
    required String title,
    super.actions,
  }) : super(
          centerTitle: false,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          titleSpacing: 4,
          title: DetailViewPopButton(title),
        );
}
