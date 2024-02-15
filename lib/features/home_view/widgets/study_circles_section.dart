import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/my_error_widget.dart';
import '../../../widgets/subsection_header.dart';
import '../repositories/study_circles_repository/study_circles_repository.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../utils/context_extensions.dart';

class StudyCirclesSection extends StatelessWidget {
  const StudyCirclesSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SubsectionHeader(
              title: context.localize!.study_circles,
              actionTitle: context.localize!.list,
              onClick: () => {}),
          const _StudyCirclesList()
        ],
      );
}

class _StudyCirclesList extends ConsumerWidget {
  const _StudyCirclesList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyCirclesRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) =>
        MyErrorWidget(StudyCirclesSectionConfig.errorMsg + error.toString()),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 16),
              child: SizedBox(
                  height: BigPreviewCardConfig.cardHeight,
                  child: ListView.builder(
                      cacheExtent: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: value == null
                              ? const MyErrorWidget(
                                  StudyCirclesSectionConfig.errorMsg)
                              : BigPreviewCard(
                                  title: value[index]?.name ?? "",
                                  shortDescription:
                                      value[index]?.description ?? "",
                                  photoUrl: value[index]?.photo?.previewUrl,
                                  onClick: () {},
                                ),
                        );
                      })),
            )
          ],
        )
    };
  }
}
