import 'package:fluttertoast/fluttertoast.dart';

import '../../../config/nav_bar_config.dart';
import '../../../theme/app_theme.dart';
import 'nested_navigator.dart';

/// Extracted logic of navigating to tabs in tab view
extension TabBarNavigator on NestedNavigator {
  void changeTabBar(NavBarEnum newTab) {
    Fluttertoast.showToast(
      msg: "Już niedługo!",
      backgroundColor:
          navigatorKey.currentContext?.colorTheme.orangePomegranade,
      gravity: ToastGravity.SNACKBAR,
    );
  }
}
