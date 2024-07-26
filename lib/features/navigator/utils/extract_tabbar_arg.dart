import "package:flutter/widgets.dart";

import "../../../config/nav_bar_config.dart";

extension ExtractTabbarArg on RouteSettings? {
  NavBarEnum? get selectedTab {
    final args = this?.arguments;
    return args is NavBarEnum ? args : null;
  }
}
