import "package:flutter/material.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/detail_views/pop_button.dart";
import "radio_luz_logo.dart";

class RadioLuzAppBar extends AppBar {
  RadioLuzAppBar(BuildContext context, {super.key, double? logoSize, double toolbarHeight = 60, super.actions})
    : super(
        primary: true,
        leadingWidth: 200,
        title: RadioLuzLogo(logoSize: logoSize),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: context.colorTheme.whiteSoap,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: toolbarHeight,
        leading: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 4), child: DetailViewPopButton()),
        ),
        actionsPadding: EdgeInsets.zero,
      );
}
