import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/big_preview_card.dart";
import "../../../../../widgets/subsection_header.dart";
import "../../../../analytics/data/clarity.dart";
import "../../../../analytics/data/clarity_events.dart" show ClarityEvents;
import "../../../../home_view/widgets/paddings.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../../science_club/science_clubs_view/model/science_clubs.dart";
import "../../../../science_club/science_clubs_view/utils/science_club_localization_extension.dart";
import "../../business/department_detail_service.dart";

class DepartmentScienceClubsSection extends ConsumerWidget {
  const DepartmentScienceClubsSection(this.departmentWithSciClubs, {super.key});
  final DepartmentWithSciClubs departmentWithSciClubs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textHeight = 260.0;
    final cardHeight = BigPreviewCardConfig.cardHeight - textHeight + context.textScaler.scale(textHeight);
    return Column(
      children: [
        SubsectionHeader(
          title: context.localize.study_circles,
          actionTitle: context.localize.list,
          onClick: () {
            unawaited(ref.navigateScienceClubs(departmentWithSciClubs.department.id.toString()));
          },
        ),
        SizedBox(
          height: cardHeight,
          child: _ScienceClubsList(scienceClubs: departmentWithSciClubs.sciclubs),
        ),
      ],
    );
  }
}

class _ScienceClubsList extends ConsumerWidget {
  final IList<ScienceClub> scienceClubs;

  const _ScienceClubsList({required this.scienceClubs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      cacheExtent: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: scienceClubs.length,
      padding: const EdgeInsets.only(right: HomeViewConfig.paddingMedium),
      itemBuilder: (BuildContext context, int index) {
        final sciClub = scienceClubs[index];
        return MediumLeftPadding(child: _ScienceClubCard(sciClub: sciClub));
      },
    );
  }
}

class _ScienceClubCard extends ConsumerWidget {
  const _ScienceClubCard({required this.sciClub});

  final ScienceClub sciClub;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BigPreviewCard(
      title: sciClub.localizedName(context),
      shortDescription: sciClub.localizedShortDescription(context),
      imageData: (sciClub.coverPreview) ? sciClub.cover : sciClub.logo,
      onClick: () async {
        unawaited(ref.trackEvent(ClarityEvents.openSciClubFromDepartmentDetailView, value: sciClub.id.toString()));
        await ref.navigateSciClubsDetail(sciClub);
      },
      showVerifiedBadge: sciClub.source == ScienceClubSource.manualEntry,
      showStrategicBadge: sciClub.isStrategic,
      imagePadding: ScienceClubConfig.imagePadding,
    );
  }
}
