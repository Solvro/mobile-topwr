import WidgetKit
import SwiftUI

@main
struct ParkingWidgetBundle: WidgetBundle {
    var body: some Widget {
        C13ParkingWidget()
        E01ParkingWidget()
        WroParkingWidget()
        GeoLParkingWidget()
        D20ParkingWidget()
    }
}
