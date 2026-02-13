import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../bottom_scroll_sheet/drag_handle.dart";
import "filters_search.dart";

class FiltersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LineHandle(),
        Center(
          child: SizedBox(
            height: 64,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 64),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(context.localize.filters, style: context.textTheme.headlineMedium),
                  ),
                ),
                const FiltersSearch(), // I need Stack cause the this lib is terribly made and it's my last hope to make it anything close to what I need
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
