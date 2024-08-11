import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../widgets/chips_loading.dart";
import "../widgets/filter_chip.dart";
import "controller/selected_tag_controller.dart";
import "repository/tags_repository.dart";

class TagsWrap extends ConsumerWidget {
  const TagsWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsRepositoryProvider);
    return switch (tags) {
      AsyncLoading() => const FilterChipsLoading(),
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final value) => Wrap(
          children: [
            for (final tag in value.whereNonNull)
              Consumer(
                builder: (context, ref, child) => MyFilterChip(
                  label: tag.name,
                  onTap: () => ref
                      .read(selectedTagControllerProvider.notifier)
                      .toggleTag(tag),
                  selected: ref.watch(
                    selectedTagControllerProvider.select(
                      (value) => value.contains(tag),
                    ), // state slicing
                  ),
                ),
              ),
          ],
        )
    };
  }
}
