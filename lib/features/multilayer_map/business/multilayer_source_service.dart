import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../branches/business/selected_branch_on_map.dart";
import "../../branches/data/model/branch.dart";
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
  final sortedBuildings = _sortBuildingsForBranch(buildings.whereType<Building>(), branch);
  final branchPolinkas = _itemsForBranch(
    polinkas.whereType<PolinkaStation>(),
    branch,
    branchOf: (station) => station.branch,
  );
  final sortedLibraries = _sortByBuildingForBranch(
    libraries.whereType<Library>(),
    branch,
    branchOf: (library) => library.branch,
    buildingOf: (library) => library.building,
    rawIdOf: (library) => library.rawId,
  );
  final sortedAeds = _sortByBuildingForBranch(
    aeds.whereType<Aed>(),
    branch,
    branchOf: (aed) => aed.branch,
    buildingOf: (aed) => aed.building,
    rawIdOf: (aed) => aed.rawId,
  );
  final sortedBicycleShowers = _sortByBuildingForBranch(
    bicycleShowers.whereType<BicycleShower>(),
    branch,
    branchOf: (shower) => shower.branch,
    buildingOf: (shower) => shower.building,
    rawIdOf: (shower) => shower.rawId,
  );
  final sortedPinkBoxes = _sortByBuildingForBranch(
    pinkBoxes.whereType<PinkBox>(),
    branch,
    branchOf: (pinkBox) => pinkBox.branch,
    buildingOf: (pinkBox) => pinkBox.building,
    rawIdOf: (pinkBox) => pinkBox.rawId,
  );
  return <MultilayerItem>[
    ...sortedBuildings.map((building) => BuildingItem(building: building)),
    ...branchPolinkas.map((station) => PolinkaItem(station: station)),
    ...sortedLibraries.map((library) => LibraryItem(library: library)),
    ...sortedAeds.map((aed) => AedItem(aed: aed)),
    ...sortedBicycleShowers.map((shower) => BicycleShowerItem(shower: shower)),
    ...sortedPinkBoxes.map((pinkBox) => PinkBoxItem(pinkBox: pinkBox)),
  ].lock;
}

IList<Building> _sortBuildingsForBranch(Iterable<Building> buildings, Branch? branch) {
  final branchBuildings = _itemsForBranch(buildings, branch, branchOf: (building) => building.branch);
  return branch == Branch.main
      ? branchBuildings.sortByCodeOrder()
      : branchBuildings.sort((a, b) => a.rawId.compareTo(b.rawId));
}

IList<T> _sortByBuildingForBranch<T>(
  Iterable<T> items,
  Branch? branch, {
  required Branch Function(T item) branchOf,
  required Building? Function(T item) buildingOf,
  required int Function(T item) rawIdOf,
}) {
  final branchItems = _itemsForBranch(items, branch, branchOf: branchOf);
  return branch == Branch.main
      ? branchItems.sortByAssociatedBuilding(
          buildingOf: buildingOf,
          tieBreaker: (a, b) => rawIdOf(a).compareTo(rawIdOf(b)),
        )
      : branchItems.sort((a, b) => rawIdOf(a).compareTo(rawIdOf(b)));
}

IList<T> _itemsForBranch<T>(Iterable<T> items, Branch? branch, {required Branch Function(T item) branchOf}) {
  return items.where((item) => branchOf(item) == branch).toIList();
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
