import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/directus_assets_url.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../widgets/my_error_widget.dart';
import '../../../widgets/subsection_header.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../bottom_nav_bar/nav_bar_config.dart';
import '../repositories/infos_repository/infos_preview_repository.dart';
import 'loading_widgets/big_scrollable_section_loading.dart';
import 'paddings.dart';

class NewsSection extends ConsumerWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
              title: context.localize.whats_up,
              onClick: () {
                ref
                    .read(bottomNavBarControllerProvider.notifier)
                    .goTo(NavBarEnum.info);
              }),
          const _NewsList()
        ],
      );
}

class _NewsList extends ConsumerWidget {
  const _NewsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infosPreviewRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.only(
              left: HomeScreenConfig.paddingMedium,
              top: HomeScreenConfig.paddingMedium),
          child: BigScrollableSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: HomeScreenConfig.paddingSmall,
                  top: HomeScreenConfig.paddingMedium),
              child: SizedBox(
                  height: BigPreviewCardConfig.cardHeight,
                  child: _NewsDataList(value.whereNonNull.toList())),
            )
          ],
        )
    };
  }
}

class _NewsDataList extends StatelessWidget {
  const _NewsDataList(this.value);

  final List<InfosPreview> value;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        cacheExtent: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) {
          return MediumLeftPadding(
            child: BigPreviewCard(
              title: value[index].title,
              shortDescription: value[index].content ?? "",
              photoUrl: value[index].cover.directusUrl,
              date: value[index].date_created,
              onClick: () {},
            ),
          );
        });
  }
}
