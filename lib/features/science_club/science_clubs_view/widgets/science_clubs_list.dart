import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/search_not_found.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "../controllers/science_clubs_view_controller.dart";
import "../model/science_clubs.dart";
import "science_club_card.dart";
import "science_clubs_view_loading.dart";

class ScienceClubsList extends ConsumerWidget {
  const ScienceClubsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsListControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ScienceClubsViewConfig.mediumPadding),
      child: switch (state) {
        AsyncValue(:final IList<ScienceClub> value) => _ScienceClubsListView(value),
        AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
        _ => const ScienceClubsViewLoading(),
      },
    );
  }
}

class _ScienceClubsListView extends ConsumerWidget {
  const _ScienceClubsListView(this.filteredCircles);

  final IList<ScienceClub> filteredCircles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (filteredCircles.isEmpty) {
      return SearchNotFound(message: context.localize.sci_circle_not_found);
    }
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: ScienceClubsViewConfig.mediumPadding),
      gridDelegate: ScienceClubsViewConfig.scienceClubsViewGridDelegate(context),
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) =>
          ScienceClubCard(filteredCircles[index], () => ref.navigateSciClubsDetail(filteredCircles[index])),
    );
  }
}
