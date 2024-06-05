import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api_base/directus_assets_url.dart';
import '../../../config/ui_config.dart';
import '../../../shared_repositories/sci_clubs_repository/scientific_circles_repository.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../widgets/my_error_widget.dart';
import '../../../widgets/subsection_header.dart';
import '../../../config/nav_bar_config.dart';
import '../../navigator/navigator/detail_view_navigator.dart';
import '../../navigator/navigator/nested_navigator.dart';
import '../../navigator/navigator/tab_bar_navigator.dart';
import 'loading_widgets/big_scrollable_section_loading.dart';
import 'paddings.dart';

class StudyCirclesSection extends ConsumerWidget {
  const StudyCirclesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
              title: context.localize.study_circles,
              actionTitle: context.localize.list,
              onClick: () {
                ref.read(navigatorProvider).changeTabBar(NavBarEnum.sciCircles);
              }),
          const _StudyCirclesList()
        ],
      );
}

class _StudyCirclesList extends ConsumerWidget {
  const _StudyCirclesList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scientificCirclesRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.only(
              left: HomeScreenConfig.paddingMedium,
              top: HomeScreenConfig.paddingMedium),
          child: BigScrollableSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Container(
          padding: const EdgeInsets.only(
            left: HomeScreenConfig.paddingSmall,
            right: HomeScreenConfig.paddingSmall,
            top: HomeScreenConfig.paddingMedium,
          ),
          height: BigPreviewCardConfig.cardHeight,
          child: _StudyCirclesDataList(
            value.whereNonNull.toList(),
          ))
    };
  }
}

class _StudyCirclesDataList extends ConsumerWidget {
  const _StudyCirclesDataList(this.studyCircles);

  final List<ScientificCircle> studyCircles;

  static void goToDetailView(WidgetRef ref, String id) {
    ref.read(navigatorProvider).navigateToStudyCircleDetails(id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        cacheExtent: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: studyCircles.length,
        itemBuilder: (BuildContext context, int index) {
          final circle = studyCircles[index];
          return MediumLeftPadding(
            child: BigPreviewCard(
                title: circle.name,
                shortDescription: circle.shortDescription ?? "",
                photoUrl: circle.logo?.filename_disk?.directusUrl,
                onClick: () => goToDetailView(ref, circle.id)),
          );
        });
  }
}
