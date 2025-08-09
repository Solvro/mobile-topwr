import "package:freezed_annotation/freezed_annotation.dart";
import "../parkings/parkings_view/models/parking.dart";

part "parking_widget_data.freezed.dart";
part "parking_widget_data.g.dart";

@freezed
abstract class ParkingWidgetData with _$ParkingWidgetData {
  const factory ParkingWidgetData({
    required String symbol,
    required String freePlaces,
    required String imageUrl,
    required String trend,
  }) = _ParkingWidgetData;

  factory ParkingWidgetData.fromJson(Map<String, dynamic> json) => _$ParkingWidgetDataFromJson(json);
}

extension ToParkingWidgetDataX on Parking {
  ParkingWidgetData toParkingWidgetData() {
    return ParkingWidgetData(symbol: symbol, freePlaces: parsedNumberOfPlaces, imageUrl: photo, trend: trend);
  }
}
