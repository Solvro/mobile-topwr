import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/subsection_header.dart";
import "../../home_view/widgets/paddings.dart";
import "../../navigator/utils/navigation_commands.dart";

import "../repositories/department_details_repository.dart";

// TODO(simon-the-shark): Resolve if the list button should redirect to list of all study circles or only ones related to the department.
class DepartmentsStudyCirclesSection extends ConsumerWidget {
  const DepartmentsStudyCirclesSection(this.studyCircles, {super.key});
  final List<StudyCircles> studyCircles;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SubsectionHeader(
          title: context.localize.study_circles,
          actionTitle: context.localize.list,
          onClick: ref.navigateSciClubs,
        ),
        SizedBox(
          height: BigPreviewCardConfig.cardHeight,
          child: _StudyCirclesList(studyCircles: studyCircles),
        ),
      ],
    );
  }
}

class _StudyCirclesList extends ConsumerWidget {
  final List<StudyCircles> studyCircles;

  const _StudyCirclesList({required this.studyCircles});

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
            onClick: () async => ref.navigateSciClubsDetail(circle.id),
          ),
        );
      },
    );
  }
}
