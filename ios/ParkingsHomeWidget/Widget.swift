import SwiftUI
import WidgetKit
import AppIntents

struct ParkingApiResponse: Codable {
    let places: [ParkingPlace]
}

struct ParkingPlace: Codable, Hashable {
    let id: String
    let liczbaMiejsc: String
    let symbol: String
    let nazwa: String
    let trend: String
    let aktywny: String
    let address: String
    let access: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case liczbaMiejsc = "liczba_miejsc"
        case symbol
        case nazwa
        case trend
        case aktywny
        case address
        case access
    }
}

struct ParkingEntity: AppEntity, Identifiable, Hashable {
    let id: String
    let name: String
    let symbol: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Parking"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(symbol) (\(name))")
    }
    
    static var defaultQuery = ParkingQuery()
}

struct ParkingQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [ParkingEntity] {
        let all = await fetchAllEntities()
        return all.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [ParkingEntity] {
        return await fetchAllEntities()
    }
    
    private func fetchAllEntities() async -> [ParkingEntity] {
        let places = await fetchParkingsFromApi()
        return places.map { ParkingEntity(id: $0.id, name: $0.nazwa, symbol: $0.symbol) }
    }
}

struct SelectParkingIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Parking"
    static var description = IntentDescription("Choose which parking lot to display.")
    
    @Parameter(title: "Parking")
    var parking: ParkingEntity?
}

func fetchParkingsFromApi() async -> [ParkingPlace] {
    let defaults = UserDefaults.standard
    let urlString = "\(WidgetConfig.parkingApiUrl)/api/v1/parkings"
    
    guard let url = URL(string: urlString) else {
        return loadCachedParkings(from: defaults)
    }
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            let apiResponse = try JSONDecoder().decode(ParkingApiResponse.self, from: data)
            let activePlaces = apiResponse.places.filter { $0.aktywny == "1" }
            if !activePlaces.isEmpty {
                defaults.set(data, forKey: "cached_parkings_raw")
                return activePlaces
            }
        }
    } catch {
        print("ParkingsWidget: fetch error: \(error)")
    }
    
    return loadCachedParkings(from: defaults)
}

func loadCachedParkings(from defaults: UserDefaults) -> [ParkingPlace] {
    guard let data = defaults.data(forKey: "cached_parkings_raw"),
          let apiResponse = try? JSONDecoder().decode(ParkingApiResponse.self, from: data) else {
        return []
    }
    return apiResponse.places.filter { $0.aktywny == "1" }
}

func getDeepLinkUrl(parkingId: String? = nil) -> URL? {
    if let id = parkingId, !id.isEmpty {
        return URL(string: "https://topwr.solvro.pl/parkings/\(id)")
    }
    return URL(string: "https://topwr.solvro.pl/parkings")
}

struct Provider: AppIntentTimelineProvider {
    typealias Entry = ParkingsHomeWidgetEntry
    typealias Intent = SelectParkingIntent
    
    func placeholder(in context: Context) -> ParkingsHomeWidgetEntry {
        ParkingsHomeWidgetEntry(
            date: Date(),
            parking: ParkingPlace(
                id: "placeholder",
                liczbaMiejsc: "45",
                symbol: "C13",
                nazwa: "Parking C-13",
                trend: "0",
                aktywny: "1",
                address: "pl. Grunwaldzki",
                access: "students"
            ),
            error: nil
        )
    }

    func snapshot(for configuration: SelectParkingIntent, in context: Context) async -> ParkingsHomeWidgetEntry {
        return placeholder(in: context)
    }

    func timeline(for configuration: SelectParkingIntent, in context: Context) async -> Timeline<ParkingsHomeWidgetEntry> {
        let allParkings = await fetchParkingsFromApi()
        
        let matchedParking: ParkingPlace?
        if let selectedId = configuration.parking?.id {
            matchedParking = allParkings.first(where: { $0.id == selectedId })
        } else {
            matchedParking = allParkings.first
        }
        
        let entry = ParkingsHomeWidgetEntry(
            date: Date(),
            parking: matchedParking,
            error: allParkings.isEmpty ? "Network offline" : (matchedParking == nil ? "Parking not found" : nil)
        )
        
        // Reload every 15 minutes to keep spots count fresh
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
        return Timeline(entries: [entry], policy: .after(nextUpdate))
    }
}

struct ParkingsHomeWidgetEntry: TimelineEntry {
    let date: Date
    let parking: ParkingPlace?
    let error: String?
}

private var isPl: Bool {
    Locale.current.identifier.hasPrefix("pl")
}

struct AppColors {
    static let primaryRed = Color(red: 0xE4/255.0, green: 0x3D/255.0, blue: 0x32/255.0)
    static let mirageDark = Color(red: 0x29/255.0, green: 0x32/255.0, blue: 0x41/255.0)
    static let soapWhite = Color(red: 0xFF/255.0, green: 0xFD/255.0, blue: 0xFC/255.0)
    static let pigeonGrey = Color(red: 0x76/255.0, green: 0x85/255.0, blue: 0x9D/255.0)
}

struct ParkingsHomeWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let isDark = colorScheme == .dark
        let textColor = isDark ? AppColors.soapWhite : AppColors.mirageDark
        let widgetUrl = getDeepLinkUrl(parkingId: entry.parking?.id)
        
        VStack(alignment: .leading, spacing: 6) {
            if let error = entry.error {
                Text("Error")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(AppColors.primaryRed)
                Text(error)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(AppColors.pigeonGrey)
            } else if let parking = entry.parking {
                HStack(alignment: .top) {
                    Text(parking.symbol)
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .foregroundColor(textColor)
                    
                    
                    Spacer()
                    
                    Image(systemName: "car.fill")
                        .foregroundColor(AppColors.primaryRed)
                        .font(.system(size: 14))
                }
                
                Spacer(minLength: 0)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(isPl ? "Dostępne miejsca" : "Available spaces")
                        .font(.system(size: 10, weight: .bold))
                        .textCase(.uppercase)
                        .foregroundColor(AppColors.pigeonGrey)

                    Text(isPl ? "Stan na: \(entry.date, style: .time)" : "As of: \(entry.date, style: .time)")
                        .font(.system(size: 8))
                        .foregroundColor(AppColors.pigeonGrey)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        let placesText = parking.liczbaMiejsc.hasPrefix("-") ? "0" : parking.liczbaMiejsc
                        Text(placesText)
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                            .foregroundColor(textColor)
                        
                        Image(systemName: trendIcon(parking.trend))
                            .foregroundColor(AppColors.pigeonGrey)
                            .font(.system(size: 18, weight: .bold))
                    }
                }
            } else {
                Text(isPl ? "Wybierz parking" : "Select parking")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(textColor)
                Text(isPl ? "Przytrzymaj długo widget, aby wybrać parking." : "Long press the widget to select a parking lot.")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(AppColors.pigeonGrey)
            }
        }
        .widgetURL(widgetUrl)
    }

    private func trendIcon(_ trend: String) -> String {
        switch trend {
        case "1": return "arrow.up.forward"
        case "-1": return "arrow.down.forward"
        default: return "arrow.right"
        }
    }
}

struct ParkingsHomeWidget: Widget {
    let kind: String = "ParkingsHomeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectParkingIntent.self, provider: Provider()) { entry in
            ParkingsHomeWidgetEntryView(entry: entry)
                .applyContainerBackground()
        }
        .configurationDisplayName(isPl ? "Dostępność miejsc parkingowych" : "Parking availability")
        .description(isPl ? "Zobacz dostępność miejsc parkingowych na wybranym parkingu" : "See available parking spaces at your selected lot")
        .supportedFamilies([.systemSmall])
    }
}

extension View {
    @ViewBuilder
    func applyContainerBackground() -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            self.containerBackground(.fill.tertiary, for: .widget)
        } else {
            self.background()
        }
    }
}

