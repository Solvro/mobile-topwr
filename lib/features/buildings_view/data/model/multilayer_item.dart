import "package:latlong2/latlong.dart";

import "../../../map_view/controllers/controllers_set.dart";
import "aed.dart";
import "building.dart";
import "library.dart";

sealed class MultilayerItem extends GoogleNavigable {}

final class LibraryItem extends MultilayerItem {
  final Library library;
  LibraryItem({required this.library});
  static const idPrefix = "library-";

  @override
  String get id => "$idPrefix${library.id}";

  @override
  LatLng get location => library.location;
}

final class AedItem extends MultilayerItem {
  final Aed aed;
  AedItem({required this.aed});
  static const idPrefix = "aed-";
  @override
  String get id => "$idPrefix${aed.id}";

  @override
  LatLng get location => aed.location;
}

final class BuildingItem extends MultilayerItem {
  final Building building;
  BuildingItem({required this.building});

  static const idPrefix = "building-";
  @override
  String get id => "$idPrefix${building.id}";
  @override
  LatLng get location => building.location;
}
