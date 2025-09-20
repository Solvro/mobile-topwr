import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../multilayer_map/data/model/aed.dart";
import "../../multilayer_map/data/model/bicycle_shower.dart";
import "../../multilayer_map/data/model/building.dart";
import "../../multilayer_map/data/model/library.dart";
import "../../multilayer_map/data/model/multilayer_item.dart";
import "../../multilayer_map/data/model/pink_box.dart";
import "../../multilayer_map/data/repositories/aed_repository.dart";
import "../../multilayer_map/data/repositories/bicycle_showers_repository.dart";
import "../../multilayer_map/data/repositories/buildings_repository.dart";
import "../../multilayer_map/data/repositories/library_repository.dart";
import "../../multilayer_map/data/repositories/pink_box_repository.dart";
import "layers_enabled_service.dart";

part "multilayer_source_service.g.dart";

@riverpod
Future<IList<MultilayerItem>> multilayerSourceService(Ref ref) async {
  final layersEnabled = await ref.watch(layersEnabledServiceProvider.future);

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
    ...buildings.whereType<Building>().map((building) => BuildingItem(building: building)),
    ...libraries.whereType<Library>().map((library) => LibraryItem(library: library)),
    ...aeds.whereType<Aed>().map((aed) => AedItem(aed: aed)),
    ...bicycleShowers.whereType<BicycleShower>().map((shower) => BicycleShowerItem(shower: shower)),
    ...pinkBoxes.whereType<PinkBox>().map((pinkBox) => PinkBoxItem(pinkBox: pinkBox)),
  ].lock;
}
