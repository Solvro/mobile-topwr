import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/data/repository/sks_menu_repository.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockMenuData = IList<SksMenuDishBase>(const [
  SksMenuDish(id: "1", name: "Chicken Salad", category: DishCategory.salad, size: "200g", price: "12.50"),
  SksMenuDish(id: "2", name: "Tomato Soup", category: DishCategory.soup, size: "300ml", price: "8.00"),
]);

@widgetbook.UseCase(name: "with-mock-data", type: SksMenuSection)
Widget useCaseSksMenuSectionMock(BuildContext context) {
  return SksMenuSection(_mockMenuData);
}

@widgetbook.UseCase(name: "from-production", type: SksMenuSection)
Widget useCaseSksMenuSectionProduction(BuildContext context) {
  return const _SksMenuSectionFromRepository();
}

class _SksMenuSectionFromRepository extends ConsumerWidget {
  const _SksMenuSectionFromRepository();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMenu = ref.watch(sksMenuRepositoryProvider);

    return asyncMenu.when(
      data: (menuData) {
        if (menuData.meals.isEmpty) {
          return const Center(child: Text("No menu items available"));
        }
        return SksMenuSection(menuData.meals.toIList());
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error loading SKS menu: $error")),
    );
  }
}
