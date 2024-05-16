import 'package:flutter/material.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../../theme/iparking_theme.dart';
import 'models/parking_model.dart';
import 'parking_chart.dart';
import 'widgets/i_parking_icons_icons.dart';

class ParkingWideTileCard extends StatelessWidget {
  const ParkingWideTileCard({
    required this.parking,
    this.onTap,
    super.key,
    required this.isActive,
  });

  final VoidCallback? onTap;
  final ParkingPlace parking;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isActive ? 297 : WideTileCardConfig.imageSize,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(parking.iParkPhotoUrl),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              color: isActive
                  ? context.colorTheme.blackMirage
                  : const Color.fromRGBO(41, 50, 65, 0.60),
            ),
            Container(
              width: double.infinity,
              padding: IParkingConfig.padding,
              child: _LeftColumn(parking, isActive),
            ),
            Container(
              width: double.infinity,
              height: WideTileCardConfig.imageSize,
              padding: IParkingConfig.padding,
              child: _RigthColumn(parking, isActive),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn(this.parking, this.isActive);

  final ParkingPlace parking;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          parking.symbol,
          style: isActive
              ? context.iParkingTheme.title.withoutShadows
              : context.iParkingTheme.title,
        ),
        Padding(
          padding: IParkingConfig.extraIndentPadd,
          child: isActive
              ? Text(
                  parking.addresFormatted,
                  style: context.iParkingTheme.subtitleLight.withoutShadows,
                )
              : Text(
                  parking.nameNormalized,
                  style: context.iParkingTheme.subtitle,
                ),
        ),
        const SizedBox(height: 2),
        if (!isActive)
          Padding(
            padding: IParkingConfig.extraIndentPadd,
            child: Text(
              parking.openingHours,
              style: context.iParkingTheme.small,
            ),
          ),
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(
                top: 18,
                left: 0,
                right: 27,
              ),
              height: 167,
              child: ParkingChart(parking),
            ),
          ),
        ),
      ],
    );
  }
}

class _RigthColumn extends StatelessWidget {
  const _RigthColumn(this.parking, this.isActive);

  final ParkingPlace parking;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isActive)
          const Icon(
            IParkingIcons.ipark_info,
            color: Colors.white,
            size: 25,
            shadows: iparkingShadows,
          ),
        if (isActive)
          const Icon(
            IParkingIcons.ip_close,
            color: Colors.white,
            size: 20,
          ),
        Text(
          parking.counterText,
          style: isActive
              ? context.iParkingTheme.title.withoutShadows
              : context.iParkingTheme.title,
        ),
      ],
    );
  }
}