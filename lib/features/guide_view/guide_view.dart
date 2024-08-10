import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../widgets/my_error_widget.dart";
import "../../utils/context_extensions.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/search_box_app_bar.dart";
import "guide_view_controller.dart";
import "widgets/about_us_section.dart";
import "widgets/guide_tile.dart";

@RoutePage()
class GuideView extends ConsumerWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guideListControllerProvider);
    final isSomethingSearched = ref.watch(isSomethingSearchedProvider);
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.guide,
        onQueryChanged:
            ref.watch(searchGuideControllerProvider.notifier).onTextChanged,
      ),
      body: switch (state) {
        AsyncLoading() => // TODO(simon-the-shark): add shimmer loading
          const CircularProgressIndicator(),
        AsyncError(:final error) => MyErrorWidget(error),
        AsyncValue(:final value) => ListView(
            children: [
              if (!isSomethingSearched) const GuideAboutUsSection(),
              for (final item in value.whereNonNull) GuideTile(item),
            ],
          )
      },
    );
  }
}
