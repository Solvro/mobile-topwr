import "dart:core";

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../home_view/widgets/paddings.dart";
import "../data/models/dish_category_enum.dart";
import "../data/models/sks_menu_data.dart";
import "../data/repository/sks_menu_repository.dart";
import "widgets/sks_menu_data_source_link.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";

@RoutePage()
class SksMenuView extends ConsumerWidget {
  const SksMenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksMenuData = ref.watch(getSksMenuDataProvider);

    return asyncSksMenuData.when(
      data: (sksMenuData) => _SksMenuView(asyncSksMenuData.value ?? {}),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _SksMenuView extends StatelessWidget {
  const _SksMenuView(this.sksMenuData);

  final Map<DishCategory, List<SksMenuDish>> sksMenuData;

  @override
  Widget build(BuildContext context) {
    final firstItem = sksMenuData.values.expand((list) => list).first;
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.home_screen),
      body: ListView(
        children: [
          SksMenuHeader(
            dateTimeOfLastUpdate: firstItem.updatedAt.toIso8601String(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: HomeViewConfig.paddingMedium,
            ),
            child: MediumHorizontalPadding(child: SksMenuSection(sksMenuData)),
          ),
          const SksMenuDataSourceLink(),
          const SizedBox(
            height: ScienceClubsViewConfig.mediumPadding,
          ),
        ],
      ),
    );
  }
}
