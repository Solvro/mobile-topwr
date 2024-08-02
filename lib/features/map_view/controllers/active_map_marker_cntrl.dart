import "package:riverpod_annotation/riverpod_annotation.dart";

import "../utils/google_maps_link_utils.dart";
import "controllers_set.dart";

mixin ActiveMarkerController<T extends GoogleNavigable>
    on AutoDisposeNotifier<T?> {
  @override
  T? build() {
    return null;
  }

  void selectItem(T item) {
    state = item;
  }

  void unselect() {
    state = null;
  }

  void toggleItem(T item) {
    if (state == item) {
      unselect();
    } else {
      selectItem(item);
    }
  }

  Future<void> launchLink() async {
    if (state != null) {
      return GoogleMapsLinkUtils.navigateTo(state!.location);
    }
  }
}
