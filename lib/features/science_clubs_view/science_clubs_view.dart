import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../utils/context_extensions.dart";
import "../../widgets/search_box_app_bar.dart";
import "../science_clubs_filters/widgets/filters_fab.dart";
import "controllers/science_clubs_view_controller.dart";
import "widgets/science_clubs_list.dart";

@RoutePage()
class ScienceClubsView extends ConsumerWidget {
  const ScienceClubsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.study_circles,
        onQueryChanged: ref
            .watch(searchScienceClubsControllerProvider.notifier)
            .onTextChanged,
      ),
      floatingActionButton: const FiltersFAB(),
      body: const ScienceClubsList(),
    );
  }
}
