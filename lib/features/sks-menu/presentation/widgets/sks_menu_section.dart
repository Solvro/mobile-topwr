import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";

import "../../data/models/dish_category_enum.dart";
import "../../data/models/sks_menu_data.dart";
import "sks_menu_tiles.dart";

class SksMenuSection extends StatelessWidget {
  const SksMenuSection(this.data, {super.key});

  final IList<SksMenuDish> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .map((dish) => dish.category)
          .toISet()
          .sorted((e1, e2) => e1.index.compareTo(e2.index))
          .map((category) {
        return SksMenuTile(
          title: category.getLocalizedName(context),
          dishes: data.where((e) => e.category == category).toList(),
        );
      }).toList(),
    );
  }
}
