import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "departments/departments_wrap.dart";
import "tags/tags_wrap.dart";
import "types/types_wrap.dart";
import "widgets/filters_header.dart";

class FiltersSheet extends ConsumerWidget {
  const FiltersSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Column(
        children: [
          FiltersHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      _Header(context.localize.org_types),
                      const TypesWrap(),
                      _Header(context.localize.departments),
                      const DepartmentsWrap(),
                      _Header(context.localize.categories),
                      const TagsWrap(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
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
