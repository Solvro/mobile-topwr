import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/my_error_widget.dart';
import '../../../widgets/subsection_header.dart';
import '../../bottom_nav_bar/nav_bar_config.dart';
import '../../iparking/controllers.dart';
import '../../iparking/models/parking_model.dart';
import '../../iparking/repositories/parkings_repo.dart';
import '../../navigator/navigator/nested_navigator.dart';
import '../../navigator/navigator/tab_bar_navigator.dart';
import 'buildings_section/building_card.dart';
import 'loading_widgets/scrollable_section_loading.dart';
import 'paddings.dart';

class ParkingSection extends ConsumerWidget {
  const ParkingSection({super.key});

  static void goToParkingsTab(WidgetRef ref) =>
      ref.read(navigatorProvider).changeTabBar(NavBarEnum.parkings);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
            title: context.localize.parkings_title,
            actionTitle: context.localize.map_button,
            onClick: () => ParkingSection.goToParkingsTab(ref),
          ),
          const _ParkingsList()
        ],
      );
}

class _ParkingsList extends ConsumerWidget {
  const _ParkingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parkingsRepoProvider);
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

  final List<ParkingPlace> parkings;

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
            imageUrl: parking.iParkPhotoUrl,
            onTap: () {
              ParkingSection.goToParkingsTab(ref);
              ref
                  .watch(activeParkingControllerProvider.notifier)
                  .selectBuilding(parking);
            },
          ),
        );
      },
    );
  }
}
