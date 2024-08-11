import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../science_clubs_view/controllers/science_clubs_view_controller.dart";
import "../filters_sheet.dart";

class FiltersFAB extends ConsumerWidget {
  const FiltersFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(areFiltersEnabledProvider);
    return FloatingActionButton(
      onPressed: () async => showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.65,
        ),
        isScrollControlled: true,
        builder: (context) => const FiltersSheet(),
      ),
      backgroundColor: isActive
          ? context.colorTheme.orangePomegranade
          : context.colorTheme.whiteSoap,
      child: Icon(
        Icons.tune,
        color: !isActive
            ? context.colorTheme.orangePomegranade
            : context.colorTheme.whiteSoap,
      ),
    );
  }
}
