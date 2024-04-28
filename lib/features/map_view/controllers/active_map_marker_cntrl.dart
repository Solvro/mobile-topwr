import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared_repositories/buildings_repository/map_buildings_repo.dart';

part "active_map_marker_cntrl.g.dart";

@Riverpod(keepAlive: false)
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
