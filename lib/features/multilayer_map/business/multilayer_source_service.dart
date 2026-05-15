import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../branches/business/selected_branch_on_map.dart";
import "../../map_layer_picker/business/layers_enabled_service.dart";
import "../data/model/aed.dart";
import "../data/model/bicycle_shower.dart";
import "../data/model/building.dart";
import "../data/model/library.dart";
import "../data/model/multilayer_item.dart";
import "../data/model/pink_box.dart";
import "../data/model/polinka_station.dart";
import "../data/repositories/aed_repository.dart";
import "../data/repositories/bicycle_showers_repository.dart";
import "../data/repositories/buildings_repository.dart";
import "../data/repositories/library_repository.dart";
import "../data/repositories/pink_box_repository.dart";
import "../data/repositories/polinkas_repository.dart";
import "../data/utils/utils.dart";

part "multilayer_source_service.g.dart";

@riverpod
Future<IList<MultilayerItem>> multilayerSourceService(Ref ref) async {
  final layersEnabled = await ref.watch(layersEnabledServiceProvider.future);
  final branch = ref.watch(selectedBranchOnMapProvider);

  final [buildings, polinkas, libraries, aeds, bicycleShowers, pinkBoxes] = await Future.wait([
    if (layersEnabled.buildingsEnabled)
      ref.watch(buildingsRepositoryProvider.future)
    else
      Future.value(const <Building>[]),
    if (layersEnabled.polinkasEnabled)
      ref.watch(polinkasRepositoryProvider.future)
    else
      Future.value(const <PolinkaStation>[]),
    if (layersEnabled.librariesEnabled)
      ref.watch(librariesRepositoryProvider.future)
    else
      Future.value(const <Library>[]),
    if (layersEnabled.aedsEnabled) ref.watch(aedsRepositoryProvider.future) else Future.value(const <Aed>[]),
    if (layersEnabled.bicycleShowersEnabled)
      ref.watch(bicycleShowersRepositoryProvider.future)
    else
      Future.value(const <BicycleShower>[]),
    if (layersEnabled.pinkBoxesEnabled)
      ref.watch(pinkBoxesRepositoryProvider.future)
    else
      Future.value(const <PinkBox>[]),
  ]);
  final sortedLibraries = libraries
      .whereType<Library>()
      .where((library) => library.branch == branch)
      .toIList()
      .sortByAssociatedBuilding(
        buildingOf: (library) => library.building,
        tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
      );
  final sortedAeds = aeds
      .whereType<Aed>()
      .where((aed) => aed.branch == branch)
      .toIList()
      .sortByAssociatedBuilding(buildingOf: (aed) => aed.building, tieBreaker: (a, b) => a.rawId.compareTo(b.rawId));
  final sortedBicycleShowers = bicycleShowers
      .whereType<BicycleShower>()
      .where((shower) => shower.branch == branch)
      .toIList()
      .sortByAssociatedBuilding(
        buildingOf: (shower) => shower.building,
        tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
      );
  final sortedPinkBoxes = pinkBoxes
      .whereType<PinkBox>()
      .where((pinkBox) => pinkBox.branch == branch)
      .toIList()
      .sortByAssociatedBuilding(
        buildingOf: (pinkBox) => pinkBox.building,
        tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
      );
  return <MultilayerItem>[
    ...buildings
        .whereType<Building>()
        .map((building) => BuildingItem(building: building))
        .where((item) => item.building.branch == branch),
    ...polinkas
        .whereType<PolinkaStation>()
        .map((station) => PolinkaItem(station: station))
        .where((item) => item.station.branch == branch),
    ...sortedLibraries.map((library) => LibraryItem(library: library)),
    ...sortedAeds.map((aed) => AedItem(aed: aed)),
    ...sortedBicycleShowers.map((shower) => BicycleShowerItem(shower: shower)),
    ...sortedPinkBoxes.map((pinkBox) => PinkBoxItem(pinkBox: pinkBox)),
  ].lock;
}

@riverpod
Future<bool> hasAnyBuildingItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<BuildingItem>().isNotEmpty;
}

@riverpod
Future<bool> hasAnyPolinkaItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<PolinkaItem>().isNotEmpty;
}

@riverpod
Future<bool> hasAnyLibraryItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<LibraryItem>().isNotEmpty;
}

@riverpod
Future<bool> hasAnyAedItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<AedItem>().isNotEmpty;
}

@riverpod
Future<bool> hasAnyBicycleShowerItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<BicycleShowerItem>().isNotEmpty;
}

@riverpod
Future<bool> hasAnyPinkBoxItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<PinkBoxItem>().isNotEmpty;
}
