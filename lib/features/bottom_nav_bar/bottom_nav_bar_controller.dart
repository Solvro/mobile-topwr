import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../navigator/utils/selected_tab_observer.dart';
import 'nav_bar_config.dart';

part 'bottom_nav_bar_controller.g.dart';

@Riverpod(keepAlive: true)
class BottomNavBarController extends _$BottomNavBarController {
  late final SelectedTabObserver selectedTabObserver =
      SelectedTabObserver(_onTabChanged);

  @override
  NavBarEnum build() {
    return NavBarEnum.home;
  }

  void _onTabChanged(NavBarEnum tab) {
    state = tab;
  }
}
