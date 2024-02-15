import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/my_error_widget.dart';
import '../loading_widgets/scrollable_section_loading.dart';
import '../../../../widgets/subsection_header.dart';
import '../../repositories/maps_list_repository/maps_list_repository.dart';
import 'building_card.dart';

class BuildingsSection extends StatelessWidget {
  const BuildingsSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SubsectionHeader(
              title: context.localize!.buildings_title,
              actionTitle: context.localize!.map_button,
              onClick: () => {}),
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
      AsyncLoading() => const Padding(
        padding: EdgeInsets.only(left: 16),
        child: ScrollableSectionLoading(),
      ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Padding(
          padding: const EdgeInsets.only(left: 6),
          child: SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final mapItem in value ?? [])
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: BuildingCard(
                      buildingName: mapItem?.code ?? "",
                      imageUrl: mapItem?.photo?.url ?? "",
                      onTap: () {
                        print(
                            "Placeholder item click for building: ${mapItem?.code}");
                      },
                    ),
                  ),
              ],
            ),
          ),
        )
    };
  }
}
