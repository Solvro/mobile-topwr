import "dart:async";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../gen/assets.gen.dart";
import "../../../../services/haptics/app_haptics.dart";
import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../data/model/multilayer_item.dart";
import "../controllers.dart";

class MultilayerMarker extends ConsumerWidget {
  const MultilayerMarker({super.key, required this.item, required this.isActive});

  final MultilayerItem item;
  final bool isActive;

  AssetGenImage get activeMapMarker => switch (item) {
    BuildingItem() => Assets.png.mapMarkers.activeMapMarker,
    PolinkaItem() => Assets.png.mapMarkers.activePolinkaMarker,
    LibraryItem() => Assets.png.mapMarkers.activeLibraryMarker,
    AedItem() => Assets.png.mapMarkers.activeAedMarker,
    BicycleShowerItem() => Assets.png.mapMarkers.activeShowerMarker,
    PinkBoxItem() => Assets.png.mapMarkers.activePinkBoxMarker,
  };
  AssetGenImage get notActiveMapMarker => switch (item) {
    BuildingItem() => Assets.png.mapMarkers.mapMarker,
    PolinkaItem() => Assets.png.mapMarkers.polinkaMarker,
    LibraryItem() => Assets.png.mapMarkers.libraryMarker,
    AedItem() => Assets.png.mapMarkers.aedMarker,
    BicycleShowerItem() => Assets.png.mapMarkers.showerMarker,
    PinkBoxItem() => Assets.png.mapMarkers.pinkBoxMarker,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        unawaited(AppHaptics.selectionClick());
        unawaited(ref.read(multilayerMapControllerProvider).onMarkerTap(item));
        return switch (item) {
          BuildingItem(:final building) => unawaited(
            ref.trackEvent(ClarityEvents.selectBuilding, value: building.name),
          ),
          PolinkaItem(:final station) => unawaited(ref.trackEvent(ClarityEvents.selectBuilding, value: station.name)),
          LibraryItem(:final library) => unawaited(ref.trackEvent(ClarityEvents.selectLibrary, value: library.title)),
          AedItem(:final aed) => unawaited(ref.trackEvent(ClarityEvents.selectAed, value: aed.title)),
          BicycleShowerItem(:final shower) => unawaited(
            ref.trackEvent(ClarityEvents.selectShower, value: shower.title(context.localize)),
          ),
          PinkBoxItem(:final pinkBox) => unawaited(
            ref.trackEvent(ClarityEvents.selectPinkBox, value: pinkBox.title(context.localize)),
          ),
        };
      },
      child: (isActive ? activeMapMarker : notActiveMapMarker).image(),
    );
  }
}
