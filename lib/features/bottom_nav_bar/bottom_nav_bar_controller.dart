import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'nav_bar_config.dart';
import '../navigator/nested_navigator.dart';

part 'bottom_nav_bar_controller.g.dart';

@Riverpod(keepAlive: true)
class BottomNavBarController extends _$BottomNavBarController {
  @override
  NavBarEnum build() {
    return NavBarEnum.home;
  }

  void onIndexChanged(int index) {
    if (index == state.index) {
      return; // prevents potencial popping of a nested view, when clicked on a current tab
    }
    ref
        .read(navigatorProvider)
        .popUntilRoot(); // pops nested views if we've went to different tab

    goTo(NavBarEnum.values[index]);
  }

  void goTo(NavBarEnum tab) {
    if (tab != state) {
      state = tab;
      ref.read(navigatorProvider).changeTabBar(tab);
    }
  }
}
