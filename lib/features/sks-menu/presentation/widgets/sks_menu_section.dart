import "package:flutter/cupertino.dart";
import "../../data/models/dish_category_enum.dart";
import "../../data/models/sks_menu_data.dart";
import "sks_menu_tiles.dart";

class SksMenuSection extends StatelessWidget {
  const SksMenuSection(this.data, {super.key});

  final Map<DishCategory, List<SksMenuDish>> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.keys.map((category) {
        return SksMenuTile(
          title: category.getLocalizedName(context),
          dishes: data[category]!,
        );
      }).toList(),
    );
  }
}
