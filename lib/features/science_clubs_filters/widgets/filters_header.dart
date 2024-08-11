import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/utils.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/subsection_header.dart";
import "../../map_view/widgets/bottom_scroll_sheet/drag_handle.dart";
import "../filters_controller.dart";

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
                boldBodyOrange: context.textTheme.titleOrange,
              ), // for text button font
              child: Consumer(
                builder: (context, ref, child) => SubsectionHeader(
                  leftPadding: 8,
                  rightPadding: 0,
                  title: context.localize.filters,
                  actionTitle: context.localize.clear,
                  addArrow: false,
                  onClick: ref.watch(areFiltersEnabledProvider)
                      ? ref.getClearAllFilters(ref)
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
}
