import 'package:flutter/widgets.dart';

import '../bottom_nav_bar/nav_bar_config.dart';

extension ExtractTabbarArg on RouteSettings? {
  NavBarEnum get selectedTab {
    final args = this?.arguments;
    if (args is NavBarEnum) {
      return args;
    }
    return NavBarEnum.home;
  }
}
