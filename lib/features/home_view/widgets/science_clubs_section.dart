import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../science_clubs_view/repository/science_clubs_repository.dart";
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
          FilledButton(
            onPressed: () {
              unawaited(ref.navigateBuildingGuideDetail());
            }, 
            //onPressed: ref.navigateGuide,
            child: const Text("Navigate to digital guide screen!"),
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
    return switch (state) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final IList<ScienceClub> value) => SmallHorizontalPadding(
          child: SizedBox(
            height: BigPreviewCardConfig.cardHeight,
            child: _ScienceClubsDataList(value),
          ),
        ),
      _ => const Padding(
          padding: EdgeInsets.only(
            left: HomeViewConfig.paddingMedium,
            top: HomeViewConfig.paddingMedium * 2,
          ),
          child: SizedBox(
            height:
                BigPreviewCardConfig.cardHeight - HomeViewConfig.paddingMedium,
            child: BigScrollableSectionLoading(),
          ),
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
        final sciClubCard = _BuildScienceClubCard(sciClub: sciClub, ref: ref);

        if (index != scienceClubs.length - 1) {
          return MediumLeftPadding(
            child: sciClubCard,
          );
        } else {
          return MediumHorizontalPadding(
            child: sciClubCard,
          );
        }
      },
    );
  }
}

class _BuildScienceClubCard extends StatelessWidget {
  const _BuildScienceClubCard({
    required this.sciClub,
    required this.ref,
  });

  final ScienceClub sciClub;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return BigPreviewCard(
      title: sciClub.name,
      shortDescription: sciClub.shortDescription ?? "",
      directusUrl: (sciClub.useCoverAsPreviewPhoto ?? false)
          ? sciClub.cover?.filename_disk
          : sciClub.logo?.filename_disk,
      onClick: () async => ref.navigateSciClubsDetail(sciClub.id),
      showBadge: sciClub.source == ScienceClubsViewConfig.source,
    );
  }
}
