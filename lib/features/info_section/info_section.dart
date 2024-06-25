import 'package:flutter/material.dart';

import '../../api_base/directus_assets_url.dart';
import '../../widgets/search_box_app_bar.dart';
import 'infos_view_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/my_error_widget.dart';
import '../../utils/where_non_null_iterable.dart';
import 'widgets/about_us_section.dart';
import 'widgets/template_section.dart';

class InfoSection extends ConsumerWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infosListProvider);
    final isSomethingSearched = ref.watch(searchInfosControllerProvider) != "";
    return Scaffold(
        appBar: SearchBoxAppBar(
          context,
          title: "Przewodnik",
          bottomPadding: 16.0,
          onQueryChanged:
              ref.watch(searchInfosControllerProvider.notifier).onTextChanged,
        ),
        body: switch (state) {
          AsyncLoading() =>
            const CircularProgressIndicator(), // TODO(simon-the-shark): add shimmer loading
          AsyncError(:final error) => MyErrorWidget(error),
          AsyncValue(:final value) => ListView(
              children: [
                if (!isSomethingSearched) const AboutUsSection(),
                for (final info in value.whereNonNull)
                  TemplateSection(
                    title: info.name ?? "",
                    description: info.short_description ?? "",
                    imagePath: info.cover?.filename_disk?.directusUrl ?? "",
                    onTap: () {},
                  ),
              ],
            )
        });
  }
}
