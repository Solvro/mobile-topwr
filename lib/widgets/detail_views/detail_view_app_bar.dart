import "package:flutter/material.dart";

import "pop_button.dart";

class DetailViewAppBar extends AppBar {
  DetailViewAppBar({
    super.key,
    super.actions,
  }) : super(
          centerTitle: false,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          titleSpacing: 4,
          title: const DetailViewPopButton(),
        );
}
