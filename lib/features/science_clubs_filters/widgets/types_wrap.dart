import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../filters_controller.dart";
import "../model/sci_club_type.dart";
import "filter_chip.dart";

class TypesWrap extends ConsumerWidget {
  const TypesWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        for (final type in ScienceClubType.values)
          Consumer(
            builder: (context, ref, child) {
              final controller =
                  ref.watch(selectedTypeControllerProvider.notifier);
              final isSelected = ref.watchContains(
                selectedTypeControllerProvider,
                type,
              );
              return MyFilterChip(
                label: context.sciClubTypeDisplayName(type),
                onTap: () => controller.toggleFilter(type),
                selected: isSelected,
              );
            },
          ),
      ],
    );
  }
}
