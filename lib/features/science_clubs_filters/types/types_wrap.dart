import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../widgets/filter_chip.dart";
import "controller/selected_type.dart";
import "model/sci_club_type.dart";

class TypesWrap extends ConsumerWidget {
  const TypesWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        for (final type in ScienceClubType.values)
          Consumer(
            builder: (context, ref, child) => MyFilterChip(
              label: context.sciClubTypeDisplayName(type),
              onTap: () => ref
                  .read(selectedTypeControllerProvider.notifier)
                  .toggleType(type),
              selected: ref.watch(
                selectedTypeControllerProvider.select(
                  (value) => value.contains(type),
                ), // state slicing
              ),
            ),
          ),
      ],
    );
  }
}
