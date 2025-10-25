import SwiftUI
import WidgetKit


private let widgetGroupId = "todo"
private let parkingWidgetDataKey = "parking_home_screen_widget_data"

struct ParkingWidgetProvider: TimelineProvider {
    
    let parkingSymbol : ParkingSymbol
    
    func placeholder(in context: Context) -> ParkingWidgetEntry {
        ParkingWidgetEntry(date: Date(), symbol: parkingSymbol.rawValue, freePlaces: "-", imageUrl: "", trend: "0")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ParkingWidgetEntry) -> ()) {
        completion(loadEntry(parkingSymbol: parkingSymbol))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ParkingWidgetEntry>) -> ()) {
        let entry = loadEntry(parkingSymbol: parkingSymbol)
    
       // let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        //let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
    
    private func loadEntry(parkingSymbol : ParkingSymbol) -> ParkingWidgetEntry {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let json = prefs?.string(forKey: parkingWidgetDataKey) ?? ""
        
        
        //TODO: adjust error handling here
        return try! decodeParkingWidget(from: json, for: parkingSymbol)
    }
}
