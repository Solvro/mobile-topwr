import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../theme/app_theme.dart";
import "../../../config/ui_config.dart";
import "../filters_controller.dart";
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
          maxHeight: MediaQuery.sizeOf(context).height *
              FilterConfig.bottomSheetHeightFactor,
        ),
        isScrollControlled: true,
        builder: (context) => const FiltersSheet(),
      ),
      backgroundColor: isActive
          ? context.colorTheme.orangePomegranade
          : context.colorTheme.whiteSoap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.tune,
              color: !isActive
                  ? context.colorTheme.orangePomegranade
                  : context.colorTheme.whiteSoap,
            ),
          ),
          if (isActive)
            Positioned(
              top: 4,
              right: 4,
              child: Icon(
                Icons.circle,
                size: 8,
                color: context.colorTheme.whiteSoap,
              ),
            ),
        ],
      ),
    );
  }
}
