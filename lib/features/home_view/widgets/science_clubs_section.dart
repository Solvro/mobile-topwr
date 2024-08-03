import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../science_clubs_view/repositories/science_clubs/science_clubs_repository.dart";
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
    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.only(
            left: HomeViewConfig.paddingMedium,
            top: HomeViewConfig.paddingMedium,
          ),
          child: BigScrollableSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Container(
          padding: const EdgeInsets.only(
            left: HomeViewConfig.paddingSmall,
            right: HomeViewConfig.paddingSmall,
            top: HomeViewConfig.paddingMedium,
          ),
          height: BigPreviewCardConfig.cardHeight,
          child: _ScienceClubsDataList(
            value.whereNonNull.toList(),
          ),
        )
    };
  }
}

class _ScienceClubsDataList extends ConsumerWidget {
  const _ScienceClubsDataList(this.scienceClubs);

  final List<ScienceClub> scienceClubs;

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
