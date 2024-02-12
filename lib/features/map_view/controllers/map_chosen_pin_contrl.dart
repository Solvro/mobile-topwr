import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/map_buildings_repo.dart';
part "map_chosen_pin_contrl.g.dart";

@riverpod
class MapChosenPinController extends _$MapChosenPinController {
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
