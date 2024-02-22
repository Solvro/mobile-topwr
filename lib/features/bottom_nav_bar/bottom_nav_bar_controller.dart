import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'nav_bar_config.dart';

part 'bottom_nav_bar_controller.g.dart';

@riverpod
class BottomNavBarController extends _$BottomNavBarController {
  @override
  NavBarEnum build() {
    return NavBarEnum.home;
  }

  void onIndexChanged(int index) {
    state = NavBarEnum.values[index];
  }

  void goTo(NavBarEnum tab) {
    state = tab;
  }
}
