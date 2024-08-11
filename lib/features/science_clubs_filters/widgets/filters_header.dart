import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/utils.dart";
import "../../../widgets/subsection_header.dart";
import "../../map_view/widgets/bottom_scroll_sheet/drag_handle.dart";
import "../../science_clubs_view/controllers/science_clubs_view_controller.dart";
import "../departments/controller/selected_department.dart";
import "../tags/controller/selected_tag_controller.dart";
import "../types/controller/selected_type.dart";

class FiltersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.whiteSoap,
      child: Column(
        children: [
          const LineHandle(),
          Center(
            child: Theme(
              data: context.defaultThemeWithOverrideTextStyles(
                boldBodyOrange: context.textTheme.boldBodyOrange.copyWith(
                  fontSize: context.textTheme.title.fontSize,
                ),
              ),
              child: Consumer(
                builder: (context, ref, child) => SubsectionHeader(
                  leftPadding: 8,
                  rightPadding: 0,
                  title: "Filtry",
                  actionTitle: "Wyczyść",
                  addArrow: false,
                  onClick: ref.watch(areFiltersEnabledProvider)
                      ? clearAllFilters(ref)
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  VoidCallback clearAllFilters(WidgetRef ref) {
    return () {
      ref.read(selectedTagControllerProvider.notifier).clear();
      ref
          .read(
            selectedDepartmentControllerProvider.notifier,
          )
          .clear();
      ref.read(selectedTypeControllerProvider.notifier).clear();
    };
  }
}
