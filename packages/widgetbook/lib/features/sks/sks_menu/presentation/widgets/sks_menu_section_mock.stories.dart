import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_section.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_menu_section_mock.stories.g.dart";

final _mockMenuData = IList<SksMenuDishBase>(const [
  SksMenuDish(id: "1", name: "Chicken Salad", category: DishCategory.salad, size: "200g", price: "12.50"),
  SksMenuDish(id: "2", name: "Tomato Soup", category: DishCategory.soup, size: "300ml", price: "8.00"),
]);

class SksMenuSectionMockStory extends StatelessWidget {
  const SksMenuSectionMockStory({super.key});

  @override
  Widget build(BuildContext context) {
    return SksMenuSection(_mockMenuData);
  }
}

const meta = Meta(SksMenuSectionMockStory.new);

final $withMockData = SksMenuSectionMockStoryStory();
