import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../hooks/use_filters_sheet_height.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "filters_controller.dart";
import "filters_search_controller.dart";
import "widgets/departments_wrap.dart";
import "widgets/filters_button.dart";
import "widgets/filters_header.dart";
import "widgets/tags_wrap.dart";
import "widgets/types_wrap.dart";

class FiltersSheet extends ConsumerWidget {
  const FiltersSheet({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.scientific_cirlces);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sheetHeight = useFiltersSheetHeight(context);
    return ProviderScope(
      overrides: [areFiltersEnabledProvider],
      child: Semantics(
        label: context.localize.filters_sheet_semantics_label,
        child: SizedBox(
          height: sheetHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                FiltersHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        TypesWrap(),
                        DepartmentsWrap(),
                        TagsWrap(),
                        _NoFiltersFound(),
                        SizedBox(height: FilterConfig.spacingBetweenWidgets),
                        SizedBox(height: FilterConfig.spacingBetweenWidgets),
                      ],
                    ),
                  ),
                ),

                SafeArea(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .04),
                          blurRadius: 16,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                      child: Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: FiltersButton(
                              text: context.localize.clear,
                              icon: Icons.close,
                              onPressed: ref.watch(areFiltersEnabledProvider) ? ref.getClearAllFilters(ref) : () {},
                              isSecondary: true,
                            ),
                          ),
                          Expanded(
                            child: FiltersButton(
                              text: context.localize.apply,
                              icon: Icons.check,
                              onPressed: context.maybePop,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FiltersSectionHeader extends StatelessWidget {
  const FiltersSectionHeader(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: context.textTheme.titleLarge),
    );
  }
}

class _NoFiltersFound extends ConsumerWidget {
  const _NoFiltersFound();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nothingFound = ref.watch(areNoFiltersFoundProvider);
    if (!nothingFound) {
      return const SizedBox.shrink();
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          // TODO(simon-the-shark): Add coool empty space here
          context.localize.filters_didnt_found_anything,
        ),
      ),
    );
  }
}
