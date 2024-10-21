import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "filters_controller.dart";
import "filters_search_controller.dart";
import "widgets/apply_filters_button.dart";
import "widgets/departments_wrap.dart";
import "widgets/filters_header.dart";
import "widgets/tags_wrap.dart";
import "widgets/types_wrap.dart";

class FiltersSheet extends StatelessWidget {
  const FiltersSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        searchFiltersControllerProvider,
        areFiltersEnabledProvider,
      ],
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height *
            FilterConfig.bottomSheetHeightFactor,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Stack(
            children: [
              Column(
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
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: ApplyFiltersButton(
                  onPressed: () {},
                ),
              ),
            ],
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
      child: Text(
        text,
        style: context.textTheme.title,
      ),
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
