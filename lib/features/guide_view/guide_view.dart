import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/my_error_widget.dart';
import '../../api_base/directus_assets_url.dart';
import '../../utils/where_non_null_iterable.dart';
import '../../widgets/search_box_app_bar.dart';
import 'guide_view_controller.dart';
import 'widgets/about_us_section.dart';
import 'widgets/template_section.dart';

class GuideView extends ConsumerWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guideListControllerProvider);
    final isSomethingSearched = ref.watch(isSomethingSearchedProvider);
    return Scaffold(
        appBar: SearchBoxAppBar(
          context,
          title: "Przewodnik",
          bottomPadding: 16.0,
          onQueryChanged:
              ref.watch(searchGuideControllerProvider.notifier).onTextChanged,
        ),
        body: switch (state) {
          AsyncLoading() =>
            const CircularProgressIndicator(), // TODO(simon-the-shark): add shimmer loading
          AsyncError(:final error) => MyErrorWidget(error),
          AsyncValue(:final value) => ListView(
              children: [
                if (!isSomethingSearched) const GuideAboutUsSection(),
                for (final item in value.whereNonNull)
                  GuideTemplateSection(
                    title: item.name ?? "",
                    description: item.short_description ?? "",
                    imagePath: item.cover?.filename_disk?.directusUrl ?? "",
                    onTap: () {},
                  ),
              ],
            )
        });
  }
}
