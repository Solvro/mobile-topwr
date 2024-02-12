import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/wide_tile_card.dart';
import '../controllers/map_chosen_pin_contrl.dart';
import '../controllers/map_view_controller.dart';
import '../repository/map_buildings_repo.dart';
import 'bottom_scroll_sheet/bottom_scroll_sheet.dart';

class BuildingsScrollSheet extends ConsumerWidget {
  const BuildingsScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState = ref.watch(mapViewControllerProvider);
    return switch (buildingsState) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) => ErrorWidget(error),
      AsyncValue(:final value) => BottomScrollSheet(
          collection: value.whereNonNull.toList(),
          itemBuilder: (BuildContext context, Building building) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: WideTileCard(
              title: building.name,
              subtitle: building.addres
                  ?.replaceFirst(",", "\n")
                  .replaceAll("\n ", "\n"),
              isActive: building == ref.watch(mapChosenPinControllerProvider),
            ),
          ),
        )
    };
  }
}
