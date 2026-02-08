import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/search_not_found.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "../../science_clubs_filters/filters_controller.dart";
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

class _ScienceClubsListView extends HookConsumerWidget {
  const _ScienceClubsListView(this.filteredCircles);

  final IList<ScienceClub> filteredCircles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();

    ref.listen<bool>(focusFirstCardProvider, (prev, next) {
      if (next) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNode.requestFocus();
        });
        ref.read(focusFirstCardProvider.notifier).state = false;
      }
    });

    if (filteredCircles.isEmpty) {
      return SearchNotFound(message: context.localize.sci_circle_not_found);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ResultsCountText(filteredCircles: filteredCircles),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: ScienceClubsViewConfig.mediumPadding),
            gridDelegate: DepartmentsConfig.departmentsViewGridDelegate(context),
            itemCount: filteredCircles.length,
            itemBuilder: (context, index) {
              return Focus(
                focusNode: index == 0 ? focusNode : null,
                child: ScienceClubCard(
                  filteredCircles[index],
                  () => ref.navigateSciClubsDetail(filteredCircles[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ResultsCountText extends ConsumerWidget {
  const _ResultsCountText({required this.filteredCircles});

  final IList<ScienceClub> filteredCircles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryIsEmpty = ref.watch(searchScienceClubsControllerProvider.select((state) => state.isEmpty));
    if (queryIsEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 8),
      child: Text(
        "${filteredCircles.length} ${context.localize.scientific_clubs_results_count}",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}
