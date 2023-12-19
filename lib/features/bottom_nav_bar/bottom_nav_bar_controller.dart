import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation_states.dart';


class BottomNavBarController extends StateNotifier<NavigationStates> {
  BottomNavBarController() : super(const NavigationStates());

  void onIndexChanged(int index) {
    state = state.copyWith(index: index);
  }
}

final navigationControllerProvider =
    StateNotifierProvider<BottomNavBarController, NavigationStates>(
        (ref) => BottomNavBarController());
