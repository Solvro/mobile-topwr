import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

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
  final [buildings, libraries, aeds, bicycleShowers, pinkBoxes] = await Future.wait([
    ref.watch(buildingsRepositoryProvider.future),
    ref.watch(librariesRepositoryProvider.future),
    ref.watch(aedsRepositoryProvider.future),
    ref.watch(bicycleShowersRepositoryProvider.future),
    ref.watch(pinkBoxesRepositoryProvider.future),
  ]);
  return <MultilayerItem>[
    ...buildings.whereType<Building>().map((building) => BuildingItem(building: building)),
    ...libraries.whereType<Library>().map((library) => LibraryItem(library: library)),
    ...aeds.whereType<Aed>().map((aed) => AedItem(aed: aed)),
    ...bicycleShowers.whereType<BicycleShower>().map((shower) => BicycleShowerItem(shower: shower)),
    ...pinkBoxes.whereType<PinkBox>().map((pinkBox) => PinkBoxItem(pinkBox: pinkBox)),
  ].lock;
}
