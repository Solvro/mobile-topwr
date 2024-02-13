import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/map_buildings_repo.dart';
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

    return ref.watch(mapBuildingsRepositoryProvider).valueOrNull?.where(
        _filterMethod); // or elsewhere a whole list, filtered by text field
  }

  bool _filterMethod(Building? building) {
    if (building == null) return false;
    final filter = _textFieldFilterText;
    return building.name.contains(filter) ||
        building.code.contains(filter) ||
        (building.addres?.contains(filter) ?? false);
  }

  void updateSearchText(String newText) {
    _textFieldFilterText = newText;
    ref.invalidateSelf();
  }
}

@riverpod
DraggableScrollableController bottomSheetController(
        BottomSheetControllerRef ref) =>
    DraggableScrollableController();
