import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'models/parking_model.dart';
import 'parking_chart.dart';

class ParkingCard extends StatelessWidget {
  const ParkingCard(this.parking, {super.key});

  final ParkingPlace parking;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: _ParkingContent(parking),
          ),
          const SizedBox(height: 20),
          SizedBox(height: 200, child: ParkingChart(parking)),
        ],
      ),
    );
  }
}

class _ParkingContent extends StatelessWidget {
  const _ParkingContent(this.parking);

  final ParkingPlace parking;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.titleWhite.copyWith(fontSize: 20);

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(parking.iParkPhotoUrl, fit: BoxFit.cover),
        const ModalBarrier(color: Colors.black26),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(parking.name, style: style),
            Text(parking.numberOfPlaces, style: style),
            Text(parking.measurementTime, style: style),
          ],
        ),
      ],
    );
  }
}
