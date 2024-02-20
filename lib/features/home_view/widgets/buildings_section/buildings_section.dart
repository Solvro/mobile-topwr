import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/context_extensions.dart';
import '../../../../utils/where_non_null_iterable.dart';
import '../../../../widgets/my_error_widget.dart';
import '../../../../widgets/subsection_header.dart';
import '../../repositories/maps_list_repository/maps_list_repository.dart';
import '../loading_widgets/scrollable_section_loading.dart';
import '../paddings.dart';
import 'building_card.dart';

class BuildingsSection extends StatelessWidget {
  const BuildingsSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SubsectionHeader(
              title: context.localize!.buildings_title,
              actionTitle: context.localize!.map_button,
              onClick: () {}),
          const _BuildingsList()
        ],
      );
}

class _BuildingsList extends ConsumerWidget {
  const _BuildingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapsListRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const MediumLeftPadding(
          child: ScrollableSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => SmallLeftPadding(
          child: SizedBox(
            height: 120,
            child: _DataListBuildingsTiles(value.whereNonNull.toList()),
          ),
        )
    };
  }
}

class _DataListBuildingsTiles extends StatelessWidget {
  const _DataListBuildingsTiles(this.buildings);

  final List<Maps> buildings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: buildings.length,
      itemBuilder: (context, index) {
        final mapItem = buildings[index];
        return MediumLeftPadding(
          child: BuildingCard(
            buildingName: mapItem.code,
            imageUrl: mapItem.photo?.url,
            onTap: () {},
          ),
        );
      },
    );
  }
}
