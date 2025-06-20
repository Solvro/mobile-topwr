import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../parkings/parkings_view/models/parking.dart";
import "../../parkings/parkings_view/repository/parkings_repository.dart";
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
      FilledButton(onPressed: ref.navigateToSksMenu, child: const Text("navigate to sks menu")),
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
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<Parking> value) => SmallHorizontalPadding(
        child: SizedBox(height: 120, child: _DataListParkingsTiles(value)),
      ),
      _ => const MediumLeftPadding(child: ScrollableSectionLoading()),
    };
  }
}

class _DataListParkingsTiles extends ConsumerWidget {
  const _DataListParkingsTiles(this.parkings);

  final IList<Parking> parkings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: parkings.length,
      itemBuilder: (context, index) {
        final parking = parkings[index];
        final parkingCard = _BuildParkingCard(parking: parking, ref: ref);

        if (index != parkings.length - 1) {
          return MediumLeftPadding(child: parkingCard);
        } else {
          return MediumHorizontalPadding(child: parkingCard);
        }
      },
    );
  }
}

class _BuildParkingCard extends StatelessWidget {
  const _BuildParkingCard({required this.parking, required this.ref});

  final Parking parking;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return BuildingCard(
      buildingName: parking.symbol,
      directusImageUrl: parking.iParkPhotoUrl,
      onTap: () async {
        unawaited(ref.navigateParking(parking));
      },
    );
  }
}
