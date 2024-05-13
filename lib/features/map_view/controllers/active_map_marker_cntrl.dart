import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin ActiveMarkerController<T> on AutoDisposeNotifier<T?> {
  @override
  T? build() {
    return null;
  }

  void selectBuilding(T item) {
    state = item;
  }

  void unselect() {
    state = null;
  }

  void toggleBuilding(T item) {
    if (state == item) {
      unselect();
    } else {
      selectBuilding(item);
    }
  }

  Future<void> launchLink();
}
