import "package:flutter/material.dart";

import "pop_button.dart";

class DetailViewAppBar extends AppBar {
  DetailViewAppBar({
    super.key,
    super.actions,
  }) : super(
          title: const DetailViewPopButton(),
          centerTitle: false,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          titleSpacing: 4,
        );
}
