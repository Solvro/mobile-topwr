import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'models/parking_model.dart';

class ParkingCard extends StatelessWidget {
  const ParkingCard(this.parking, {super.key});
  final ParkingPlace parking;
  @override
  Widget build(BuildContext context) {
    print(
      parking.iParkPhotoUrl,
    );
    final style = context.textTheme.titleWhite.copyWith(fontSize: 20);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(parking.iParkPhotoUrl, fit: BoxFit.cover),
            ),
            const ModalBarrier(color: Colors.black26),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    parking.name,
                    style: style,
                  ),
                  Text(
                    parking.numberOfPlaces,
                    style: style,
                  ),
                  Text(
                    parking.measurementTime,
                    style: style,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
