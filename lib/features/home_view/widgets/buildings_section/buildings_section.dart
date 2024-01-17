import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/loading_widget.dart';
import '../../repositories/maps_list_repository.dart';
import 'building_card.dart';

class BuildingsSection extends StatelessWidget {
  const BuildingsSection({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        children: [_SectionHeader(), _BuildingsList()],
      );
}

class _BuildingsList extends ConsumerWidget {
  const _BuildingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapsListRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) => ErrorWidget(error),
      AsyncValue(:final value) => Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final mapItem in value ?? [])
                  BuildingCard(
                    buildingName: mapItem?.code ?? "",
                    imageUrl: mapItem?.photo?.url ?? "",
                    onTap: () {
                      print(
                          "Placeholder item click for building: ${mapItem?.code}");
                    },
                  ),
              ],
            ),
          ),
        )
    };
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(children: [
          Text(context.localize!.buildings_title,
              style: context.textTheme.headline),
          const Spacer(),
          GestureDetector(
            onTap: () {
              print("Placeholder map click");
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                context.localize!.map_button,
                style: context.textTheme.boldBodyOrange,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: context.colorTheme.orangePomegranade,
                size: 16,
              )
            ]),
          )
        ]));
  }
}
