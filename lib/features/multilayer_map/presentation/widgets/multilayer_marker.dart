import "dart:async";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../gen/assets.gen.dart";
import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";

class MultilayerMarker extends ConsumerWidget {
  const MultilayerMarker({super.key, required this.item, required this.isActive});

  final MultilayerItem item;
  final bool isActive;

  String get activeMapMarker => switch (item) {
    BuildingItem() => Assets.png.mapMarkers.activeMapMarker.path,
    LibraryItem() => Assets.png.mapMarkers.activeLibraryMarker.path,
    AedItem() => Assets.png.mapMarkers.activeAedMarker.path,
    BicycleShowerItem() => Assets.png.mapMarkers.activeShowerMarker.path,
    PinkBoxItem() => Assets.png.mapMarkers.activePinkBoxMarker.path,
  };
  String get notActiveMapMarker => switch (item) {
    BuildingItem() => Assets.png.mapMarkers.mapMarker.path,
    LibraryItem() => Assets.png.mapMarkers.libraryMarker.path,
    AedItem() => Assets.png.mapMarkers.aedMarker.path,
    BicycleShowerItem() => Assets.png.mapMarkers.showerMarker.path,
    PinkBoxItem() => Assets.png.mapMarkers.pinkBoxMarker.path,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(item));
        return switch (item) {
          BuildingItem(:final building) => unawaited(ref.trackEvent(UmamiEvents.selectBuilding, value: building.name)),
          LibraryItem(:final library) => unawaited(ref.trackEvent(UmamiEvents.selectLibrary, value: library.title)),
          AedItem(:final aed) => unawaited(ref.trackEvent(UmamiEvents.selectAed, value: aed.title)),
          BicycleShowerItem(:final shower) => unawaited(
            ref.trackEvent(UmamiEvents.selectShower, value: shower.title(context.localize)),
          ),
          PinkBoxItem(:final pinkBox) => unawaited(
            ref.trackEvent(UmamiEvents.selectPinkBox, value: pinkBox.title(context.localize)),
          ),
        };
      },
      child: Image.asset(isActive ? activeMapMarker : notActiveMapMarker),
    );
  }
}
