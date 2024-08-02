import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../utils/context_extensions.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/search_box_app_bar.dart";
import "controllers/science_clubs_view_controller.dart";
import "repositories/tags/tags_repository.dart";
import "widgets/science_clubs_list.dart";
import "widgets/tags_loading.dart";
import "widgets/tags_row.dart";

@RoutePage()
class ScienceClubsView extends ConsumerWidget {
  const ScienceClubsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.study_circles,
        bottomPadding: 16,
        onQueryChanged: ref
            .watch(searchScienceClubsControllerProvider.notifier)
            .onTextChanged,
      ),
      body: const _SciClubsBody(),
    );
  }
}

class _SciClubsBody extends ConsumerWidget {
  const _SciClubsBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsRepositoryProvider);
    return Column(
      children: [
        SizedBox(
          height: 76,
          child: switch (tags) {
            AsyncLoading() => const TagsLoading(),
            AsyncError() => const SizedBox.shrink(),
            AsyncValue(:final value) => TagsRow(
                allTags: value.whereNonNull.toList(),
              )
          },
        ),
        const ScienceClubsList(),
      ],
    );
  }
}
