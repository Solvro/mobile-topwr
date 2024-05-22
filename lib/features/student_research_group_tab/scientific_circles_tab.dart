import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/context_extensions.dart';
import '../../utils/where_non_null_iterable.dart';
import '../../widgets/search_box_app_bar.dart';
import 'repositories/scientific_circles_tab_controller.dart';
import 'repositories/tags_repository.dart';
import 'widgets/scientific_circles_list.dart';
import 'widgets/tags_loading.dart';
import 'widgets/tags_row.dart';

class ScientificCirclesTab extends ConsumerWidget {
  const ScientificCirclesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: SearchBoxAppBar(
          context,
          title: context.localize.study_circles,
          bottomPadding: 16.0,
          onQueryChanged: ref
              .watch(searchScientificCirclesControllerProvider.notifier)
              .onTextChanged,
        ),
        body: const _ScientificCirclesBody());
  }
}

class _ScientificCirclesBody extends ConsumerWidget {
  const _ScientificCirclesBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsListRepositoryProvider);
    return Column(children: [
      SizedBox(
        height: 76.0,
        child: switch (tags) {
          AsyncLoading() => const TagsLoading(),
          AsyncError() => const SizedBox.shrink(),
          AsyncValue(:final value) => TagsRow(
              allTags: value.whereNonNull.toList(),
            )
        },
      ),
      const ScientificCirclesList()
    ]);
  }
}
