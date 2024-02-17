import 'package:flutter/material.dart';

import '../config.dart';
import '../theme/app_theme.dart';
import 'search_widget.dart';

class SearchBoxAppBar extends AppBar {
  static const bottomPadding = 32.0;
  static const horizontalPadding = 24.0;

  SearchBoxAppBar(
    BuildContext context, {
    required String title,
    required void Function(String query) onQueryChanged,
    super.actions,
    super.primary,
    super.key,
    VoidCallback? onSearchboxTap,
  }) : super(
          title: Text(title),
          titleTextStyle: context.textTheme.headline,
          backgroundColor: context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleSpacing: horizontalPadding,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
                SearchWidgetConfig.height + bottomPadding),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: bottomPadding,
                left: horizontalPadding,
                right: horizontalPadding,
              ),
              child: SearchWidget(
                onQueryChanged: onQueryChanged,
                onTap: onSearchboxTap,
              ),
            ),
          ),
        );
}
