import "package:flutter/material.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "is_following_controller.dart";

class MyLocationLayer extends StatelessWidget {
  const MyLocationLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final isFollowingCurrLoc =
            ref.watch(isFollowingCurrentLocationControllerProvider);
        return CurrentLocationLayer(
          alignPositionOnUpdate:
              isFollowingCurrLoc ? AlignOnUpdate.always : AlignOnUpdate.never,
        );
      },
    );
  }
}
