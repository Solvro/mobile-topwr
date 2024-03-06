import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/buildings_repository/map_buildings_repo.dart';
import 'active_map_marker_cntrl.dart';

part "buildings_listview_controller.g.dart";

@riverpod
class BuildingsListViewController extends _$BuildingsListViewController {
  String _textFieldFilterText = "";

  @override
  Future<Iterable<Building?>?> build() async {
    final buildingSelected = ref.watch(activeMapMarkerControllerProvider);
    if (buildingSelected != null) {
      return [buildingSelected]; // shows only selected building
    }

    final buildingsData =
        await ref.watch(mapBuildingsRepositoryProvider.future);

    return buildingsData?.where(
        _filterMethod); // or elsewhere a whole list, filtered by text field
  }

  bool _filterMethod(Building? building) {
    if (building == null) return false;
    final filter = _textFieldFilterText.toLowerCase();
    return building.name.toLowerCase().contains(filter) ||
        building.code.toLowerCase().contains(filter) ||
        (building.addres?.toLowerCase().contains(filter) ?? false);
  }

  void onSearchQueryChanged(String newText) {
    _textFieldFilterText = newText;
    ref.read(activeMapMarkerControllerProvider.notifier).unselect();
    ref.invalidateSelf();
  }
}
