import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/iparking_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_tooltip.dart";
import "../../parking_chart/parking_chart.dart";
import "../models/parking.dart";
import "parking_favourite.dart";

class ParkingWideTileCard extends StatelessWidget {
  const ParkingWideTileCard({required this.parking, this.onTap, super.key, required this.isActive});

  final VoidCallback? onTap;
  final Parking parking;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    return GestureDetector(
      onTap: isActive ? null : onTap,
      child: Container(
        height: isActive ? scaler.clamp(maxScaleFactor: 1.5).scale(300) : scaler.scale(WideTileCardConfig.imageSize),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(parking.iParkPhotoUrl)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(color: isActive ? context.colorTheme.blackMirage : const Color.fromRGBO(41, 50, 65, 0.60)),
            Container(
              width: double.infinity,
              padding: ParkingsConfig.padding.copyWith(bottom: 8 / context.textScaler.scale(1)),
              child: _LeftColumn(parking, isActive: isActive),
            ),
            Container(
              width: double.infinity,
              height: WideTileCardConfig.imageSize,
              padding: ParkingsConfig.padding,
              child: _RightColumn(parking, isActive: isActive),
            ),
            if (!isActive) Positioned(top: 1, right: 2, child: FavouriteParkingWidget(parking)),
            if (isActive)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onTap,
                  icon: Semantics(
                    button: true,
                    label: context.localize.close,
                    child: Icon(Icons.close, color: context.colorTheme.whiteSoap, size: scaler.scale(22)),
                  ),
                ),
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
    return Semantics(
      label: isActive ? context.localize.parking_chart_title_screen_reader_label : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            parking.symbol,
            style: isActive ? context.iParkingTheme.title.withoutShadows : context.iParkingTheme.title,
          ),
          Padding(
            padding: ParkingsConfig.extraIndentPadd,
            child:
                isActive
                    ? Text(
                      "${context.localize.street_abbreviation} ${parking.addressFormatted}",
                      style: context.iParkingTheme.subtitleLight.withoutShadows,
                      textScaler: context.textScaler.clamp(maxScaleFactor: 2),
                    )
                    : Text(parking.nameNormalized, style: context.iParkingTheme.subtitle),
          ),
          const SizedBox(height: 2),
          if (!isActive)
            Flexible(
              child: Padding(
                padding: ParkingsConfig.extraIndentPadd,
                child: Semantics(
                  label: context.localize.parking_opening_hours_reader_label,
                  child: Text(parking.openingHours, style: context.iParkingTheme.small),
                ),
              ),
            ),
          if (isActive) Expanded(child: Center(child: ParkingChart(parking))),
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn(this.parking, {required this.isActive});

  final Parking parking;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        Semantics(
          label:
              "${context.localize.parking_people_live_screen_reader_label} ${parking.parsedNumberOfPlaces} ${context.localize.sks_people_live_screen_reader_label_trend}${localizedName(parking.trend, context)}",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ExcludeSemantics(
                child: MyTooltip(
                  message: context.localize.places_currently_available,
                  child: Text(
                    parking.parsedNumberOfPlaces,
                    style: isActive ? context.iParkingTheme.title.withoutShadows : context.iParkingTheme.title,
                  ),
                ),
              ),
              SizedBox(width: scaler.scale(4)),
              Icon(
                parking.trend.arrowIcon,
                color: isActive ? arrowColor(parking.trend, context) : context.colorTheme.whiteSoap,
                size: scaler.scale(21),
                shadows: iparkingShadows,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Color arrowColor(String trend, BuildContext context) {
  switch (trend) {
    case "1":
      return const Color(0xFF28a745); //green arrow
    case "-1":
      return const Color(0xFFdc3545); //red arrow
    default:
      return context.colorTheme.whiteSoap;
  }
}

String localizedName(String trend, BuildContext context) {
  switch (trend) {
    case "1":
      return context.localize.sks_people_live_screen_reader_label_trend_increasing;
    case "-1":
      return context.localize.sks_people_live_screen_reader_label_trend_decreasing;
    default:
      return context.localize.sks_people_live_screen_reader_label_trend_stable;
  }
}
