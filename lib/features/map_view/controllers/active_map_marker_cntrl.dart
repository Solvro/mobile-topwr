import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin ActiveMarkerController<T> on AutoDisposeNotifier<T?> {
  @override
  T? build() {
    return null;
  }

  void selectBuilding(T building) {
    state = building;
  }

  void unselect() {
    state = null;
  }

  void toggleBuilding(T building) {
    if (state == building) {
      unselect();
    } else {
      selectBuilding(building);
    }
  }
}
