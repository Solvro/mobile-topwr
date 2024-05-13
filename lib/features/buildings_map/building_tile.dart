import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared_repositories/buildings_repository/building_extra_params_ext.dart';
import '../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/wide_tile_card.dart';
import 'controllers.dart';

class BuildingTile extends ConsumerWidget {
  const BuildingTile(
    this.building, {
    super.key,
  });

  final Building building;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      activeGradient: context.colorTheme.toPwrGradient,
      photoUrl: building.photo?.url,
      title: "${context.localize.building_prefix} ${building.name}",
      subtitle: building.addresFormatted,
      isActive: ref.watchIsActive(building),
      onTap: () {
        ref.read(buildingsMapControllerProvider.notifier).onMarkerTap(building);
      },
    );
  }
}
