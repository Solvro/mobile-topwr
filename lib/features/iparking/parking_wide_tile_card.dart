import 'package:flutter/material.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import 'models/parking_model.dart';

class ParkingWideTileCard extends StatelessWidget {
  const ParkingWideTileCard({
    required this.parking,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final ParkingPlace parking;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: WideTileCardConfig.imageSize,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(parking.iParkPhotoUrl),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: const Color.fromRGBO(41, 50, 65, 0.60),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 13,
                top: 10,
                bottom: 16,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    parking.symbol,
                    style: context.iParkingTheme.title,
                  ),
                  Text(
                    parking.nameNormalized,
                    style: context.iParkingTheme.subtitle,
                  ),
                  Text(
                    parking.openingHours,
                    style: context.iParkingTheme.small,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
