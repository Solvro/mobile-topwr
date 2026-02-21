import "multilayer_item.dart";

/// Represents the different section types in the multilayer map
enum MultilayerSectionType {
  building,
  library,
  aed,
  bicycleShower,
  pinkBox;

  /// Gets the item ID prefix for this section type
  String get idPrefix => switch (this) {
    MultilayerSectionType.building => BuildingItem.idPrefix,
    MultilayerSectionType.library => LibraryItem.idPrefix,
    MultilayerSectionType.aed => AedItem.idPrefix,
    MultilayerSectionType.bicycleShower => BicycleShowerItem.idPrefix,
    MultilayerSectionType.pinkBox => PinkBoxItem.idPrefix,
  };
}
