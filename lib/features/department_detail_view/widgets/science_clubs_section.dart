import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../home_view/widgets/loading_widgets/big_scrollable_section_loading.dart";
import "../../home_view/widgets/paddings.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../science_clubs_view/repository/science_clubs_repository.dart";
import "../repository/department_details_repository.dart";

// TODO(simon-the-shark): Resolve if the list button should redirect to list of all study circles or only ones related to the department., #165
class DepartmentScienceClubsSection extends ConsumerWidget {
  const DepartmentScienceClubsSection(this.department, {super.key});
  final DepartmentDetails? department;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsRepositoryProvider);
    return switch (state) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final IList<ScienceClub> value) => Builder(
          builder: (context) {
            final filtered = value
                .where(
                  (sciClubs) =>
                      sciClubs.department?.id ==
                      department?.Departments_by_id?.id,
                )
                .toIList();
            return Column(
              children: [
                SubsectionHeader(
                  title: context.localize.study_circles,
                  actionTitle: context.localize.list,
                  onClick: () async {
                    unawaited(
                      ref.navigateScienceClub(
                        department?.Departments_by_id?.id,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: BigPreviewCardConfig.cardHeight,
                  child: _ScienceClubsList(scienceClubs: filtered),
                ),
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
            directusUrl: (sciClub.useCoverAsPreviewPhoto ?? false)
                ? sciClub.cover?.filename_disk
                : sciClub.logo?.filename_disk,
            onClick: () async => ref.navigateSciClubsDetail(sciClub.id),
          ),
        );
      },
    );
  }
}
