import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/nav_bar_config.dart';
import '../../config/navigator_config.dart';
import '../navigator/utils/selected_tab_observer.dart';

part 'bottom_nav_bar_controller.g.dart';

@Riverpod(keepAlive: true)
class BottomNavBarController extends _$BottomNavBarController {
  late final SelectedTabObserver selectedTabObserver =
      SelectedTabObserver(_onTabChanged);

  @override
  NavBarEnum build() {
    return NavigatorConfig.initialTab;
  }

  void _onTabChanged(NavBarEnum tab) {
    if (state != tab) {
      state = tab;
    }
  }
}
