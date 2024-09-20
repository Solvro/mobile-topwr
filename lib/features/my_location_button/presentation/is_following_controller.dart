import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/location_permission_status_provider.dart";

part "is_following_controller.g.dart";

@riverpod
class IsFollowingCurrentLocationController
    extends _$IsFollowingCurrentLocationController {
  @override
  bool build() {
    return false;
  }

  Future<void> buttonClicked() async {
    final isGranted = await ref.read(locationPermissionStatusProvider.future);
    if (isGranted) {
      state = true;
    }
  }

  void mapMoved() {
    if (state) {
      state = false;
    }
  }
}
