import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../branches/business/selected_branch_on_map.dart";
import "../../map_layer_picker/business/layers_enabled_service.dart";
import "../data/model/aed.dart";
import "../data/model/bicycle_shower.dart";
import "../data/model/building.dart";
import "../data/model/library.dart";
import "../data/model/multilayer_item.dart";
import "../data/model/pink_box.dart";
import "../data/repositories/aed_repository.dart";
import "../data/repositories/bicycle_showers_repository.dart";
import "../data/repositories/buildings_repository.dart";
import "../data/repositories/library_repository.dart";
import "../data/repositories/pink_box_repository.dart";

part "multilayer_source_service.g.dart";

@riverpod
Future<IList<MultilayerItem>> multilayerSourceService(Ref ref) async {
  final layersEnabled = await ref.watch(layersEnabledServiceProvider.future);
  final branch = ref.watch(selectedBranchOnMapProvider);

  final [buildings, libraries, aeds, bicycleShowers, pinkBoxes] = await Future.wait([
    if (layersEnabled.buildingsEnabled)
      ref.watch(buildingsRepositoryProvider.future)
    else
      Future.value(const <Building>[]),
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
  return <MultilayerItem>[
    ...buildings
        .whereType<Building>()
        .map((building) => BuildingItem(building: building))
        .where((item) => item.building.branch == branch),
    ...libraries
        .whereType<Library>()
        .map((library) => LibraryItem(library: library))
        .where((item) => item.library.branch == branch),
    ...aeds.whereType<Aed>().map((aed) => AedItem(aed: aed)).where((item) => item.aed.branch == branch),
    ...bicycleShowers
        .whereType<BicycleShower>()
        .map((shower) => BicycleShowerItem(shower: shower))
        .where((item) => item.shower.branch == branch),
    ...pinkBoxes
        .whereType<PinkBox>()
        .map((pinkBox) => PinkBoxItem(pinkBox: pinkBox))
        .where((item) => item.pinkBox.branch == branch),
  ].lock;
}

@riverpod
Future<bool> hasAnyBuildingItems(Ref ref) async {
  final items = await ref.watch(multilayerSourceServiceProvider.future);
  return items.whereType<BuildingItem>().isNotEmpty;
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
