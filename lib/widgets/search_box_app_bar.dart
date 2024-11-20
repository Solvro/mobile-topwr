import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";
import "search_box.dart";

class SearchBoxAppBar extends AppBar {
  static const defaultBottomPadding = 16.0;
  static const defaultHorizontalPadding = 24.0;

  SearchBoxAppBar(
    BuildContext context, {
    required String title,
    required void Function(String query) onQueryChanged,
    super.actions,
    super.primary,
    super.key,
    VoidCallback? onSearchBoxTap,
    double bottomPadding = defaultBottomPadding,
    bool addLeadingPopButton = false,
  }) : super(
          title: Text(title),
          titleTextStyle: context.textTheme.headline,
          backgroundColor: context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          centerTitle: addLeadingPopButton,
          titleSpacing: defaultHorizontalPadding,
          automaticallyImplyLeading: false,
          leading: addLeadingPopButton
              ? IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: context.colorTheme.orangePomegranade,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(SearchBoxConfig.height + bottomPadding),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: bottomPadding,
                left: defaultHorizontalPadding,
                right: defaultHorizontalPadding,
              ),
              child: SearchBox(
                onQueryChanged: onQueryChanged,
                onTap: onSearchBoxTap,
              ),
            ),
          ),
        );
}
