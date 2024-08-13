import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "../repository/tags_repository.dart";
import "chips_loading.dart";
import "filter_chip.dart";

class TagsWrap extends ConsumerWidget {
  const TagsWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagFiltersFilteredProvider);
    return switch (tags) {
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final IList<Tag> value) => Wrap(
          children: [
            for (final tag in value.whereNonNull)
              Consumer(
                builder: (context, ref, child) {
                  final controller =
                      ref.watch(selectedTagControllerProvider.notifier);
                  final isSelected = ref.watchContains(
                    selectedTagControllerProvider,
                    tag,
                  );
                  return MyFilterChip(
                    label: tag.name,
                    onTap: () => controller.toggleFilter(tag),
                    selected: isSelected,
                  );
                },
              ),
          ],
        ),
      _ => const FilterChipsLoading(),
    };
  }
}
