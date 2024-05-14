import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../widgets/wide_tile_card.dart';
import 'controllers.dart';
import 'models/parking_model.dart';

class ParkingTile extends ConsumerWidget {
  const ParkingTile(
    this.parking,
    this.isActive, {
    super.key,
  });

  final ParkingPlace parking;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      activeGradient: context.colorTheme.toPwrGradient,
      photoUrl: parking.iParkPhotoUrl,
      title: parking.symbol,
      subtitle: parking.addresFormatted,
      isActive: isActive,
      onTap: () {
        ref.read(parkingsMapControllerProvider.notifier).onMarkerTap(parking);
      },
    );
  }
}
