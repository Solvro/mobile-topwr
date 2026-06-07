import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../map_view/utils/lat_lng_validity.dart";
import "../data/location_permission_status_provider.dart";
import "is_following_controller.dart";

// ignore: solvro_config/hooks_extends hooks are inside HookBuilder
class MyLocationLayer extends ConsumerWidget {
  const MyLocationLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPermGranted = ref.watch(locationPermissionStatusProvider).value ?? false;
    if (!isPermGranted) {
      return const SizedBox.shrink();
    }
    final isFollowingCurrLoc = ref.watch(isFollowingCurrentLocationControllerProvider);
    return HookBuilder(
      builder: (BuildContext context) {
        // ignore: close_sinks (hook handles closing the stream)
        final zoomStream = useStreamController<double>();
        final wasPreviouslyFollowingCurrLoc = usePrevious(isFollowingCurrLoc) ?? false;
        final triggerImmiediateZoom = !wasPreviouslyFollowingCurrLoc && isFollowingCurrLoc;
        if (triggerImmiediateZoom) {
          zoomStream.add(18);
        }

        return IgnorePointer(
          child: CurrentLocationLayer(
            positionStream: const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream().where(
              (position) => position != null && position.isValidForMap,
            ),
            alignPositionStream: zoomStream.stream,
            alignPositionOnUpdate: isFollowingCurrLoc ? AlignOnUpdate.always : AlignOnUpdate.never,
          ),
        );
      },
    );
  }
}
