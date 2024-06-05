import 'package:flutter/material.dart';

import '../config/ui_config.dart';
import '../theme/app_theme.dart';
import 'search_widget.dart';

class SearchBoxAppBar extends AppBar {
  static const defaultBottomPadding = 32.0;
  static const defaultHorizontalPadding = 24.0;

  SearchBoxAppBar(
    BuildContext context, {
    required String title,
    required void Function(String query) onQueryChanged,
    super.actions,
    super.primary,
    super.key,
    VoidCallback? onSearchboxTap,
    double bottomPadding = defaultBottomPadding,
  }) : super(
          automaticallyImplyLeading: false,
          title: Text(title),
          titleTextStyle: context.textTheme.headline,
          backgroundColor: context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleSpacing: defaultHorizontalPadding,
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(SearchWidgetConfig.height + bottomPadding),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: bottomPadding,
                left: defaultHorizontalPadding,
                right: defaultHorizontalPadding,
              ),
              child: SearchWidget(
                onQueryChanged: onQueryChanged,
                onTap: onSearchboxTap,
              ),
            ),
          ),
        );
}
