import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../../map_view/controllers/controllers_set.dart";
import "aed.dart";
import "bicycle_shower.dart";
import "building.dart";
import "library.dart";
import "pink_box.dart";

part "multilayer_item.freezed.dart";

sealed class MultilayerItem extends GoogleNavigable {}

@freezed
abstract class LibraryItem with _$LibraryItem implements MultilayerItem {
  @Implements<MultilayerItem>()
  const factory LibraryItem({required Library library}) = _LibraryItem;
  const LibraryItem._();

  static const idPrefix = "library-";

  @override
  String get id => "$idPrefix${library.id}";

  @override
  LatLng get location => library.location;
}

@freezed
abstract class AedItem with _$AedItem implements MultilayerItem {
  @Implements<MultilayerItem>()
  const factory AedItem({required Aed aed}) = _AedItem;
  const AedItem._();

  static const idPrefix = "aed-";

  @override
  String get id => "$idPrefix${aed.id}";

  @override
  LatLng get location => aed.location;
}

@freezed
abstract class BuildingItem with _$BuildingItem implements MultilayerItem {
  @Implements<MultilayerItem>()
  const factory BuildingItem({required Building building}) = _BuildingItem;
  const BuildingItem._();

  static const idPrefix = "building-";

  @override
  String get id => "$idPrefix${building.id}";

  @override
  LatLng get location => building.location;
}

@freezed
abstract class BicycleShowerItem with _$BicycleShowerItem implements MultilayerItem {
  @Implements<MultilayerItem>()
  const factory BicycleShowerItem({required BicycleShower shower}) = _BicycleShowerItem;
  const BicycleShowerItem._();

  static const idPrefix = "bicycle-shower-";
}

@freezed
abstract class PinkBoxItem with _$PinkBoxItem implements MultilayerItem {
  @Implements<MultilayerItem>()
  const factory PinkBoxItem({required PinkBox pinkBox}) = _PinkBoxItem;
  const PinkBoxItem._();

  static const idPrefix = "pink-box-";
}
