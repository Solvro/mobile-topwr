import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../theme/app_theme.dart";
import "../../../../theme/iparking_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../models/parking.dart";
import "../repository/local_fav_parking_repository.dart";

class FavouriteParkingWidget extends ConsumerWidget {
  const FavouriteParkingWidget(this.parking);
  final Parking parking;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(localFavParkingsRepositoryProvider(parking.id));

    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: () async {
        await ref.read(localFavParkingsRepositoryProvider(parking.id).notifier).toggle();
      },
      icon:
          isFavorite == null
              ? FavouriteIcon(icon: Icons.error, color: context.colorTheme.whiteSoap)
              : FavouriteIcon(
                icon: isFavorite ? Icons.favorite_rounded : Icons.favorite_border_outlined,
                color: isFavorite ? context.colorTheme.orangePomegranade : context.colorTheme.whiteSoap,
              ),
    );
  }
}

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    return Semantics(
      button: true,
      label: context.localize.favourite_button,
      child: Icon(icon, color: color, size: scaler.scale(22), shadows: iparkingShadows),
    );
  }
}
