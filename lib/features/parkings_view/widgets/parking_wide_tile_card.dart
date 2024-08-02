import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../theme/iparking_theme.dart";
import "../../parking_chart/parking_chart.dart";
import "../models/parking.dart";
import "parkings_icons.icons.dart";

class ParkingWideTileCard extends StatelessWidget {
  const ParkingWideTileCard({
    required this.parking,
    this.onTap,
    super.key,
    required this.isActive,
  });

  final VoidCallback? onTap;
  final Parking parking;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isActive ? 300 : WideTileCardConfig.imageSize,
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
              padding: ParkingsConfig.padding,
              child: _LeftColumn(parking, isActive: isActive),
            ),
            Container(
              width: double.infinity,
              height: WideTileCardConfig.imageSize,
              padding: ParkingsConfig.padding,
              child: _RightColumn(parking, isActive: isActive),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn(this.parking, {required this.isActive});

  final Parking parking;
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
          padding: ParkingsConfig.extraIndentPadd,
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
            padding: ParkingsConfig.extraIndentPadd,
            child: Text(
              parking.openingHours,
              style: context.iParkingTheme.small,
            ),
          ),
        if (isActive)
          Expanded(
            child: Center(
              child: ParkingChart(parking),
            ),
          ),
      ],
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn(this.parking, {required this.isActive});

  final Parking parking;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isActive)
          const Icon(
            ParkingsIcons.ipark_info,
            color: Colors.white,
            size: 25,
            shadows: iparkingShadows,
          ),
        if (isActive)
          const Icon(
            ParkingsIcons.ip_close,
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
