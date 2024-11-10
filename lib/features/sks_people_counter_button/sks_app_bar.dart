import "package:flutter/material.dart";

import "../../theme/app_theme.dart";
import "../home_view/widgets/logo_app_bar.dart";
import "widgets/sks_user_data_button.dart";

class SksAppBar extends AppBar {
  SksAppBar(
    BuildContext context, {
    super.key,
  }) : super(
          title: const AppBarLogo(),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          actions: [
            SksUserDataButton(
              key: key,
            ),
          ],
          automaticallyImplyLeading: false,
        );
}
