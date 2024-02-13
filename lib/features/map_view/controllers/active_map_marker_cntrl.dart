import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/map_buildings_repo.dart';

part "active_map_marker_cntrl.g.dart";

@riverpod
class ActiveMapMarkerController extends _$ActiveMapMarkerController {
  @override
  Building? build() {
    return null;
  }

  void selectBuilding(Building building) {
    state = building;
  }

  void unselect() {
    state = null;
  }

  void toggleBuilding(Building building) {
    if (state == building) {
      unselect();
    } else {
      selectBuilding(building);
    }
  }
}
