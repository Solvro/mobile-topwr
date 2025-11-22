import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";
import "detail_views/pop_button.dart";
import "search_box.dart";

class SearchBoxAppBar extends AppBar {
  static const defaultBottomPadding = 16.0;
  static const defaultHorizontalPadding = 24.0;

  SearchBoxAppBar(
    BuildContext context, {
    required String title,
    required void Function(String query) onQueryChanged,
    super.actions,
    super.key,
    VoidCallback? onSearchBoxTap,
    double bottomPadding = defaultBottomPadding,
    bool addLeadingPopButton = false,
    String? initialQuery,
    super.primary = false,
  }) : super(
         title: Text(title, textScaler: context.textScaler.clamp(maxScaleFactor: 2.5)),
         titleTextStyle: context.textTheme.headline,
         backgroundColor: context.colorTheme.whiteSoap,
         scrolledUnderElevation: 0,
         centerTitle: addLeadingPopButton,
         titleSpacing: addLeadingPopButton ? 0 : defaultHorizontalPadding,
         automaticallyImplyLeading: false,
         leading: addLeadingPopButton
             ? const Align(
                 alignment: Alignment.centerLeft,
                 child: Padding(padding: EdgeInsets.only(left: 4), child: DetailViewPopButton()),
               )
             : null,
         leadingWidth: addLeadingPopButton ? 80 : 0,
         bottom: PreferredSize(
           preferredSize: Size.fromHeight(
             context.textScaler.clamp(maxScaleFactor: 2.5).scale(SearchBoxConfig.height) + bottomPadding,
           ),
           child: Padding(
             padding: EdgeInsets.only(
               bottom: bottomPadding,
               left: defaultHorizontalPadding,
               right: defaultHorizontalPadding,
             ),

             child: Semantics(
               button: true,
               label: context.localize.search,
               child: SearchBox(onQueryChanged: onQueryChanged, onTap: onSearchBoxTap, initialQuery: initialQuery),
             ),
           ),
         ),
       );
}
