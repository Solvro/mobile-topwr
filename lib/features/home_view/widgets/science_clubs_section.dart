import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../science_club/science_clubs_view/model/science_clubs.dart";
import "../../science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "loading_widgets/big_scrollable_section_loading.dart";
import "paddings.dart";

class ScienceClubsSection extends ConsumerWidget {
  const ScienceClubsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    children: [
      SubsectionHeader(
        title: context.localize.study_circles,
        actionTitle: context.localize.list,
        onClick: ref.navigateScienceClubs,
      ),
      const _ScienceClubsList(),
    ],
  );
}

class _ScienceClubsList extends ConsumerWidget {
  const _ScienceClubsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsRepositoryProvider);
    const textHeight = 260.0;
    final cardHeight = BigPreviewCardConfig.cardHeight - textHeight + context.textScaler.scale(textHeight);
    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<ScienceClub> value) => SmallHorizontalPadding(
        child: SizedBox(height: cardHeight, child: _ScienceClubsDataList(value)),
      ),
      _ => Padding(
        padding: const EdgeInsets.only(left: HomeViewConfig.paddingMedium, top: HomeViewConfig.paddingMedium * 2),
        child: SizedBox(height: cardHeight - HomeViewConfig.paddingMedium, child: const BigScrollableSectionLoading()),
      ),
    };
  }
}

class _ScienceClubsDataList extends ConsumerWidget {
  const _ScienceClubsDataList(this.scienceClubs);

  final IList<ScienceClub> scienceClubs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      cacheExtent: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: scienceClubs.length,
      itemBuilder: (BuildContext context, int index) {
        final sciClub = scienceClubs[index];
        final sciClubCard = _ScienceClubCard(sciClub: sciClub);
        if (index != scienceClubs.length - 1) {
          return MediumLeftPadding(child: sciClubCard);
        } else {
          return MediumHorizontalPadding(child: sciClubCard);
        }
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
      title: sciClub.name,
      shortDescription: sciClub.shortDescription ?? "",
      directusUrl: (sciClub.coverPreview) ? sciClub.cover?.url : sciClub.logo?.url,
      showVerifiedBadge: sciClub.source == ScienceClubSource.manualEntry,
      onClick: () async => ref.navigateSciClubsDetail(sciClub),
      showStrategicBadge: sciClub.isStrategic,
    );
  }
}
