import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../../../widgets/my_error_widget.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../repositories/science_clubs/science_clubs_repository.dart";
import "science_club_card.dart";
import "science_clubs_view_loading.dart";

class ScienceClubsList extends ConsumerWidget {
  const ScienceClubsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsRepositoryProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ScienceClubsViewConfig.mediumPadding,
        ),
        child: switch (state) {
          AsyncLoading() => const ScienceClubsViewLoading(),
          AsyncError(:final error) => MyErrorWidget(error),
          AsyncValue(:final value) =>
            _ScienceClubsListView(value.whereNonNull.toList()),
        },
      ),
    );
  }
}

class _ScienceClubsListView extends ConsumerWidget {
  const _ScienceClubsListView(this.filteredCircles);

  final List<ScienceClub> filteredCircles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (filteredCircles.isEmpty) {
      return Center(
        child: Text(
          context.localize.sci_circle_not_found,
          style: context.textTheme.body,
        ),
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
