import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../parkings_view/controllers.dart";
import "../../parkings_view/models/parking.dart";
import "../../parkings_view/repository/parkings_repository.dart";
import "buildings_section/building_card.dart";
import "loading_widgets/scrollable_section_loading.dart";
import "paddings.dart";

class ParkingsSection extends ConsumerWidget {
  const ParkingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
            title: context.localize.parkings_title,
            actionTitle: context.localize.map_button,
            onClick: ref.navigateParkings,
          ),
          const _ParkingsList(),
        ],
      );
}

class _ParkingsList extends ConsumerWidget {
  const _ParkingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parkingsRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const MediumLeftPadding(
          child: ScrollableSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => SmallHorizontalPadding(
          child: SizedBox(
            height: 120,
            child: _DataListParkingsTiles(value.whereNonNull.toList()),
          ),
        )
    };
  }
}

class _DataListParkingsTiles extends ConsumerWidget {
  const _DataListParkingsTiles(this.parkings);

  final List<Parking> parkings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: parkings.length,
      itemBuilder: (context, index) {
        final parking = parkings[index];
        return MediumLeftPadding(
          child: BuildingCard(
            buildingName: parking.symbol,
            directusImageUrl: parking.iParkPhotoUrl,
            onTap: () async {
              unawaited(ref.navigateParkings());
              ref
                  .watch(activeParkingControllerProvider.notifier)
                  .selectItem(parking);
            },
          ),
        );
      },
    );
  }
}
