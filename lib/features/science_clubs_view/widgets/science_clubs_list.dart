import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/search_not_found.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../controllers/science_clubs_view_controller.dart";
import "../repository/science_clubs_repository.dart";
import "science_club_card.dart";
import "science_clubs_view_loading.dart";

class ScienceClubsList extends ConsumerWidget {
  const ScienceClubsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsListControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ScienceClubsViewConfig.mediumPadding,
      ),
      child: switch (state) {
        AsyncValue(:final Iterable<ScienceClub?> value) =>
          _ScienceClubsListView(value.whereNonNull.toList()),
        AsyncError(:final error) => MyErrorWidget(error),
        _ => const ScienceClubsViewLoading(),
      },
    );
  }
}

class _ScienceClubsListView extends ConsumerWidget {
  const _ScienceClubsListView(this.filteredCircles);

  final List<ScienceClub> filteredCircles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (filteredCircles.isEmpty) {
      return SearchNotFound(
        message: context.localize.sci_circle_not_found,
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: ScienceClubsViewConfig.mediumPadding,
      ),
      gridDelegate: ScienceClubsViewConfig.researchGroupTabGridDelegate,
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) => ScienceClubCard(
        filteredCircles[index],
        () async => ref.navigateSciClubsDetail(filteredCircles[index].id),
      ),
    );
  }
}
