import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../map_toolbar/presentation/is_following_controller.dart";
import "../utils/google_maps_link_utils.dart";
import "controllers_set.dart";

mixin ActiveMarkerController<T extends GoogleNavigable> on AutoDisposeNotifier<T?> {
  @override
  T? build() {
    return null;
  }

  void selectItem(T item) {
    ref.read(isFollowingCurrentLocationControllerProvider.notifier).mapMoved();
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
      return GoogleMapsLinkUtils.navigateTo(state!.location, null);
    }
  }
}
