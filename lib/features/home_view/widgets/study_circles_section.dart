import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../widgets/my_error_widget.dart';
import '../../../widgets/subsection_header.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../bottom_nav_bar/nav_bar_config.dart';
import '../repositories/study_circles_repository/study_circles_repository.dart';
import 'loading_widgets/big_scrollable_section_loading.dart';
import 'paddings.dart';

class StudyCirclesSection extends ConsumerWidget {
  const StudyCirclesSection(this.onNavigate, {super.key});

  final Function(String) onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
              title: context.localize!.study_circles,
              actionTitle: context.localize!.list,
              onClick: () {
                ref
                    .read(bottomNavBarControllerProvider.notifier)
                    .goTo(NavBarEnum.sciCircles);
              }),
          _StudyCirclesList(onNavigate)
        ],
      );
}

class _StudyCirclesList extends ConsumerWidget {
  const _StudyCirclesList(this.onNavigate);

  final Function(String) onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyCirclesRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.only(
              left: HomeScreenConfig.paddingMedium,
              top: HomeScreenConfig.paddingMedium),
          child: BigScrollableSectionLoading(),
        ),
      AsyncError(:final error) =>
        MyErrorWidget(StudyCirclesSectionConfig.errorMsg + error.toString()),
      AsyncValue(:final value) => Container(
          padding: const EdgeInsets.only(
            left: HomeScreenConfig.paddingSmall,
            top: HomeScreenConfig.paddingMedium,
          ),
          height: BigPreviewCardConfig.cardHeight,
          child: _StudyCirclesDataList(value.whereNonNull.toList(), onNavigate),
        )
    };
  }
}

class _StudyCirclesDataList extends StatelessWidget {
  const _StudyCirclesDataList(this.studyCircles, this.onNavigate);

  final Function(String) onNavigate;

  final List<InfosPreview> studyCircles;

  @override
  Widget build(BuildContext context) {
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
              shortDescription: circle.description,
              photoUrl: circle.photo?.previewUrl,
              onClick: (){
                onNavigate(circle.id);
              }
            ),
          );
        });
  }
}
