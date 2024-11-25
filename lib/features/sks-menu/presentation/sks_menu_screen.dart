import "dart:core";

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";

import "../../home_view/widgets/paddings.dart";
import "../data/models/sks_menu_response.dart";
import "../data/repository/sks_menu_repository.dart";
import "widgets/sks_menu_data_source_link.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";
import "widgets/sks_menu_view_loading.dart";

@RoutePage()
class SksMenuView extends ConsumerWidget {
  const SksMenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksMenuData = ref.watch(getSksMenuDataProvider);

    // TODO(mikolaj-jalocha): Add lottie animation on: error and when data is empty (sks's closed)
    return asyncSksMenuData.when(
      data: (sksMenuData) => _SksMenuView(
        asyncSksMenuData.value ??
            SksMenuResponse(
              isMenuOnline: false,
              lastUpdate: DateTime.now(),
              meals: List.empty(),
            ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Error with SKS menu API: $error"),
          ),
        ),
      ),
      loading: SksMenuViewLoading.new,
    );
  }
}

class _SksMenuView extends StatelessWidget {
  const _SksMenuView(this.sksMenuData);

  final SksMenuResponse sksMenuData;

  @override
  Widget build(BuildContext context) {
    if (sksMenuData.meals.isEmpty) {
      return const Scaffold(
        body: Center(
          child: SksMenuViewLoading(),
        ),
      );
    }
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.home_screen),
      body: ListView(
        children: [
          SksMenuHeader(
            dateTimeOfLastUpdate: sksMenuData.lastUpdate.toIso8601String(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: HomeViewConfig.paddingMedium,
            ),
            child: MediumHorizontalPadding(
              child: SksMenuSection(sksMenuData.meals),
            ),
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
