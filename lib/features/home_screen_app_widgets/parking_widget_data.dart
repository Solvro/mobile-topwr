import "../parkings/parkings_view/models/parking.dart";

class ParkingWidgetData {
  final String symbol;
  final String freePlaces;
  final String imageUrl;
  final String trend;

  const ParkingWidgetData({
    required this.symbol,
    required this.freePlaces,
    required this.imageUrl,
    required this.trend,
  });

  Map<String, dynamic> toJson() {
    return {"symbol": symbol, "freePlaces": freePlaces, "imageUrl": imageUrl, "trend": trend};
  }
}

extension ToParkingWidgetDataX on Parking {
  ParkingWidgetData toParkingWidgetData() {
    return ParkingWidgetData(symbol: symbol, freePlaces: parsedNumberOfPlaces, imageUrl: photo, trend: trend);
  }
}
