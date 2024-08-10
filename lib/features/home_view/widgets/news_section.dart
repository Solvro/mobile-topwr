import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../guide_view/repository/guide_repository.dart";
import "../../navigator/utils/navigation_commands.dart";
import "loading_widgets/big_scrollable_section_loading.dart";
import "paddings.dart";

// TODO(mikolaj-jalocha): change guide posts to actuall news posts

class NewsSection extends ConsumerWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
            title: context.localize.guide,
            onClick: ref.navigateGuide,
          ),
          const _NewsList(),
        ],
      );
}

class _NewsList extends ConsumerWidget {
  const _NewsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guideRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.only(
            left: HomeViewConfig.paddingMedium,
            top: HomeViewConfig.paddingMedium *
                2, // twice the padding of normal state, just to look cool
          ),
          child: SizedBox(
            height:
                BigPreviewCardConfig.cardHeight - HomeViewConfig.paddingMedium,
            child: BigScrollableSectionLoading(),
          ),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: HomeViewConfig.paddingSmall,
                right: HomeViewConfig.paddingSmall,
                top: HomeViewConfig.paddingMedium,
              ),
              child: SizedBox(
                height: BigPreviewCardConfig.cardHeight,
                child: _NewsDataList(value.whereNonNull.toList()),
              ),
            ),
          ],
        )
    };
  }
}

class _NewsDataList extends ConsumerWidget {
  const _NewsDataList(this.value);

  final List<GuidePosts> value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      cacheExtent: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: value.length,
      itemBuilder: (BuildContext context, int index) {
        return MediumLeftPadding(
          child: BigPreviewCard(
            title: value[index].name ?? "",
            shortDescription: value[index].short_description ?? "",
            photoUrl: value[index].cover?.filename_disk?.directusUrl,
            onClick: () {
              unawaited(ref.navigateGuideDetail(value[index].id));
            },
          ),
        );
      },
    );
  }
}
