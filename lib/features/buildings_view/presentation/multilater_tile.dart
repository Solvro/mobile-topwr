import "package:flutter/material.dart";

import "../data/model/multilayer_item.dart";
import "aed_tile.dart";
import "building_tile.dart";
import "library_tile.dart";

class MultilayerItemTile extends StatelessWidget {
  const MultilayerItemTile(this.item, {required this.isActive, super.key});

  final MultilayerItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final localItem = item;
    return switch (localItem) {
      BuildingItem() => BuildingTile(localItem.building, isActive: isActive),
      LibraryItem() => LibraryTile(localItem.library, isActive: isActive),
      AedItem() => AedTile(localItem.aed, isActive: isActive),
    };
  }
}
