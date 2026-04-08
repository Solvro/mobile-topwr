import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/sks/sks_menu/data/repository/sks_menu_repository.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_section.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_menu_section_production.stories.g.dart";

class SksMenuSectionProductionStory extends ConsumerWidget {
  const SksMenuSectionProductionStory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMenu = ref.watch(sksMenuRepositoryProvider);

    return asyncMenu.when(
      data: (menuData) {
        if (menuData.meals.isEmpty) {
          return const Center(child: Text("No menu items available"));
        }
        return SksMenuSection(menuData.meals);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error loading SKS menu: $error")),
    );
  }
}

const meta = Meta<SksMenuSectionProductionStory>();

final $fromProduction = SksMenuSectionProductionStoryStory();
