import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../controllers.dart";
import "../models/parking.dart";
import "parking_wide_tile_card.dart";

class ParkingTile extends ConsumerWidget {
  const ParkingTile(this.parking, {required this.isActive, super.key});

  final Parking parking;
  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ParkingWideTileCard(
      parking: parking,
      isActive: isActive,
      onTap: () {
        if (!isActive) {
          unawaited(ref.trackEvent(UmamiEvents.openParkingChart, value: parking.nameNormalized));
        }
        unawaited(ref.read(parkingsMapControllerProvider).onMarkerTap(parking));
      },
    );
  }
}
