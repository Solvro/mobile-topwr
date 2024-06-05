import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/ui_config.dart';
import '../../../shared_repositories/sci_clubs_repository/scientific_circles_repository.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/my_error_widget.dart';
import '../../navigator/navigator/detail_view_navigator.dart';
import '../../navigator/navigator/nested_navigator.dart';
import '../repositories/scientific_circles_tab_controller.dart';
import 'scientific_circle_card.dart';
import 'scientific_circle_loading.dart';

class ScientificCirclesList extends ConsumerWidget {
  const ScientificCirclesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scientificCircleListProvider);

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ScientificCirclesTabConfig.mediumPadding),
            child: switch (state) {
              AsyncLoading() => const ScientificCirclesLoading(),
              AsyncError(:final error) => MyErrorWidget(error),
              AsyncValue(:final value) =>
                _ScientificCirclesDataView(value.whereNonNull.toList()),
            }));
  }
}

class _ScientificCirclesDataView extends ConsumerWidget {
  const _ScientificCirclesDataView(this.filteredCircles);

  final List<ScientificCircle> filteredCircles;

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
          bottom: ScientificCirclesTabConfig.mediumPadding),
      gridDelegate: ScientificCirclesTabConfig.researchGroupTabGridDelegate,
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) =>
          ResearchGroupCard(filteredCircles[index], () {
        ref
            .read(navigatorProvider)
            .navigateToStudyCircleDetails(filteredCircles[index].id);
      }),
    );
  }
}
