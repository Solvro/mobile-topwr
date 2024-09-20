import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "is_following_controller.dart";

class MyLocationLayer extends ConsumerWidget {
  const MyLocationLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowingCurrLoc =
        ref.watch(isFollowingCurrentLocationControllerProvider);
    return HookBuilder(
      builder: (BuildContext context) {
        // ignore: close_sinks (hook handles closing the stream)
        final zoomStream = useStreamController<double>();
        final wasPreviouslyFollowingCurrLoc =
            usePrevious(isFollowingCurrLoc) ?? false;
        final triggerImmiediateZoom =
            !wasPreviouslyFollowingCurrLoc && isFollowingCurrLoc;
        if (triggerImmiediateZoom) {
          zoomStream.add(18);
        }

        return CurrentLocationLayer(
          alignPositionStream: zoomStream.stream,
          alignPositionOnUpdate:
              isFollowingCurrLoc ? AlignOnUpdate.always : AlignOnUpdate.never,
        );
      },
    );
  }
}
