import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../theme/iparking_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../parking_chart/parking_chart.dart";
import "../models/parking.dart";

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
                  "${context.localize.street_abbreviation} ${parking.addresFormatted}",
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
        _FavouriteWidget(parking: parking),
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

class _FavouriteWidget extends StatefulWidget {
  const _FavouriteWidget({required this.parking});
  final Parking parking;

  @override
  State<_FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<_FavouriteWidget> {
  bool _isFavourite = false;

  Future<bool> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(widget.parking.id) ?? false;
  }

  Future<void> _updatePreference() async {
    setState(() {
      _isFavourite = !_isFavourite;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.parking.id, _isFavourite);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _updatePreference,
      child: FutureBuilder(
        future: Future.microtask(_loadPreference),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
              size: 25,
              shadows: iparkingShadows,
            );
          } else if (snapshot.hasError) {
            return const FavouriteIcon(
              icon: Icons.error,
            );
          } else {
            _isFavourite = snapshot.data ?? false;
            return FavouriteIcon(
              icon: _isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
            );
          }
        },
      ),
    );
  }
}

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
      size: 25,
      shadows: iparkingShadows,
    );
  }
}
