import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/subsection_header.dart";
import "../../home_view/widgets/paddings.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../repository/department_details_repository.dart";

// TODO(simon-the-shark): Resolve if the list button should redirect to list of all study circles or only ones related to the department.
class DepartmentScienceClubsSection extends ConsumerWidget {
  const DepartmentScienceClubsSection(this.scienceClubs, {super.key});
  final List<ScienceClubs> scienceClubs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SubsectionHeader(
          title: context.localize.study_circles,
          actionTitle: context.localize.list,
          onClick: ref.navigateScienceClubs,
        ),
        SizedBox(
          height: BigPreviewCardConfig.cardHeight,
          child: _ScienceClubsList(scienceClubs: scienceClubs),
        ),
      ],
    );
  }
}

class _ScienceClubsList extends ConsumerWidget {
  final List<ScienceClubs> scienceClubs;

  const _ScienceClubsList({required this.scienceClubs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      cacheExtent: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: scienceClubs.length,
      itemBuilder: (BuildContext context, int index) {
        final sciClub = scienceClubs[index];
        return MediumLeftPadding(
          child: BigPreviewCard(
            title: sciClub.name,
            shortDescription: sciClub.shortDescription ?? "",
            photoUrl: sciClub.logo?.filename_disk?.directusUrl,
            onClick: () async => ref.navigateSciClubsDetail(sciClub.id),
          ),
        );
      },
    );
  }
}
