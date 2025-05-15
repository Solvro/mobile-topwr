import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/big_preview_card.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../../widgets/subsection_header.dart";
import "../../../../analytics/data/umami.dart";
import "../../../../analytics/data/umami_events.dart" show UmamiEvents;
import "../../../../home_view/widgets/loading_widgets/big_scrollable_section_loading.dart";
import "../../../../home_view/widgets/paddings.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../../science_club/science_clubs_view/model/science_clubs.dart";
import "../../../../science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "../../data/models/department_details.dart";

class DepartmentScienceClubsSection extends ConsumerWidget {
  const DepartmentScienceClubsSection(this.department, {super.key});
  final DepartmentDetails department;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsRepositoryProvider);
    const textHeight = 260.0;
    final cardHeight = BigPreviewCardConfig.cardHeight - textHeight + context.textScaler.scale(textHeight);
    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<ScienceClub> value) => Builder(
        builder: (context) {
          final filtered = value.where((sciClubs) => sciClubs.department?.id == department.id).toIList();
          return Column(
            children: [
              SubsectionHeader(
                title: context.localize.study_circles,
                actionTitle: context.localize.list,
                onClick: () async {
                  unawaited(ref.navigateScienceClubs(department.id.toString()));
                },
              ),
              SizedBox(height: cardHeight, child: _ScienceClubsList(scienceClubs: filtered)),
            ],
          );
        },
      ),
      _ => const BigScrollableSectionLoading(),
    };
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
        return MediumLeftPadding(
          child: BigPreviewCard(
            title: sciClub.name,
            shortDescription: sciClub.shortDescription ?? "",
            directusUrl: (sciClub.coverPreview) ? sciClub.cover?.url : sciClub.logo?.url,
            onClick: () async {
              unawaited(ref.trackEvent(UmamiEvents.openSciClubFromDepartmentDetailView, value: sciClub.id.toString()));
              await ref.navigateSciClubsDetail(sciClub);
            },
            showVerifiedBadge: sciClub.source == ScienceClubsViewConfig.source,
            showStrategicBadge: sciClub.isStrategic,
          ),
        );
      },
    );
  }
}
