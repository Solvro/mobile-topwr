import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/layer_options.dart";
import "../data/local_layers_repository.dart";

part "layers_enabled_service.g.dart";

typedef AllLayersEnabled = ({
  bool buildingsEnabled,
  bool polinkasEnabled,
  bool librariesEnabled,
  bool aedsEnabled,
  bool bicycleShowersEnabled,
  bool pinkBoxesEnabled,
});

@riverpod
Future<AllLayersEnabled> layersEnabledService(Ref ref) async {
  final [
    buildingsEnabled,
    polinkasEnabled,
    librariesEnabled,
    aedsEnabled,
    bicycleShowersEnabled,
    pinkBoxesEnabled,
  ] = await Future.wait([
    ref.watch(localLayersRepositoryProvider(const BuildingLayerOptions()).future),
    ref.watch(localLayersRepositoryProvider(const PolinkaLayerOptions()).future),
    ref.watch(localLayersRepositoryProvider(const LibraryLayerOptions()).future),
    ref.watch(localLayersRepositoryProvider(const AedLayerOptions()).future),
    ref.watch(localLayersRepositoryProvider(const BicycleShowerLayerOptions()).future),
    ref.watch(localLayersRepositoryProvider(const PinkBoxLayerOptions()).future),
  ]);
  return (
    buildingsEnabled: buildingsEnabled,
    polinkasEnabled: polinkasEnabled,
    librariesEnabled: librariesEnabled,
    aedsEnabled: aedsEnabled,
    bicycleShowersEnabled: bicycleShowersEnabled,
    pinkBoxesEnabled: pinkBoxesEnabled,
  );
}

@riverpod
Future<bool> areOnlyOneLayerEnabled(Ref ref) async {
  final layersEnabled = await ref.watch(layersEnabledServiceProvider.future);
  return [
        layersEnabled.buildingsEnabled,
        layersEnabled.polinkasEnabled,
        layersEnabled.librariesEnabled,
        layersEnabled.aedsEnabled,
        layersEnabled.bicycleShowersEnabled,
        layersEnabled.pinkBoxesEnabled,
      ].where((e) => e).length ==
      1;
}
