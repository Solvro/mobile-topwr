import "dart:async";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../gen/assets.gen.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";

class MultilayerMarker extends ConsumerWidget {
  const MultilayerMarker({super.key, required this.item, required this.isActive});

  final MultilayerItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        unawaited(ref.trackEvent(UmamiEvents.selectBuilding, value: item.toString()));
        unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(item));
      },
      child: Image.asset(isActive ? Assets.png.mapMarkers.activeMapMarker.path : Assets.png.mapMarkers.mapMarker.path),
    );
  }
}
