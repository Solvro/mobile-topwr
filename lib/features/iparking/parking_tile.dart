import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/parking_model.dart';
import 'parking_wide_tile_card.dart';

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
    return ParkingWideTileCard(parking: parking);
    //ref.read(parkingsMapControllerProvider.notifier).onMarkerTap(parking);
  }
}
