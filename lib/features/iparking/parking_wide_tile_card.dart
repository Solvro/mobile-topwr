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
            Container(color: const Color.fromRGBO(41, 50, 65, 0.60)),
            Padding(
              padding: IParkingConfig.padding,
              child: _LeftColumn(parking),
            ),
            Padding(
              padding: IParkingConfig.padding,
              child: _RigthColumn(parking),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn(this.parking);

  final ParkingPlace parking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          parking.symbol,
          style: context.iParkingTheme.title,
        ),
        Padding(
          padding: IParkingConfig.extraIndentPadd,
          child: Text(
            parking.nameNormalized,
            style: context.iParkingTheme.subtitle,
          ),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: IParkingConfig.extraIndentPadd,
          child: Text(
            parking.openingHours,
            style: context.iParkingTheme.small,
          ),
        )
      ],
    );
  }
}

class _RigthColumn extends StatelessWidget {
  const _RigthColumn(this.parking);

  final ParkingPlace parking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.info,
          color: Colors.white,
        ),
        Text(
          parking.counterText,
          style: context.iParkingTheme.title,
        ),
      ],
    );
  }
}
