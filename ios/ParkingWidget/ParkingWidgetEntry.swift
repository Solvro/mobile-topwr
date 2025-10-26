import SwiftUI
import WidgetKit

struct ParkingWidgetEntry: TimelineEntry, Codable {
    let date: Date
    let symbol: String
    let freePlaces: String
    let imageUrl: String
    let trend: String
}
