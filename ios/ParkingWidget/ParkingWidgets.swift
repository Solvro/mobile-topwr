import SwiftUI
import WidgetKit

struct C13ParkingWidget: Widget {
    let parkingSymbol = ParkingSymbol.C13
    
    var body: some WidgetConfiguration {
        makeWidgetConfiguration(parkingSymbol: parkingSymbol)
    }
}

struct E01ParkingWidget: Widget {
    let parkingSymbol = ParkingSymbol.E01
    
    var body: some WidgetConfiguration {
        makeWidgetConfiguration(parkingSymbol: parkingSymbol)
    }
}

struct WroParkingWidget: Widget {
    let parkingSymbol = ParkingSymbol.WRO
    
    var body: some WidgetConfiguration {
        makeWidgetConfiguration(parkingSymbol: parkingSymbol)
    }
}

struct GeoLParkingWidget: Widget {
    let parkingSymbol = ParkingSymbol.GEO_L
    
    var body: some WidgetConfiguration {
        makeWidgetConfiguration(parkingSymbol: parkingSymbol)
    }
}

struct D20ParkingWidget: Widget {
    let parkingSymbol = ParkingSymbol.D20
    
    var body: some WidgetConfiguration {
        makeWidgetConfiguration(parkingSymbol: parkingSymbol)
    }
}

private func makeWidgetConfiguration(parkingSymbol: ParkingSymbol) -> some WidgetConfiguration {
        StaticConfiguration(
            kind: parkingSymbol.rawValue,
            provider: ParkingWidgetProvider(parkingSymbol: parkingSymbol)
        ) { entry in
            ParkingView(
                parkingImageURL: entry.imageUrl,
                parkingSymbol: entry.symbol,
                numberOfFreePlaces: entry.freePlaces,
                trend: entry.trend
            )
        }
    }
