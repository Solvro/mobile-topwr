import SwiftUI
import WidgetKit

struct AcademicCalendarResponse: Codable {
    let data: [AcademicCalendar]
}

struct AcademicCalendar: Codable {
    let id: Int
    let name: String
    let semesterStartDate: Date
    let examSessionStartDate: Date
    let examSessionLastDate: Date
    let isFirstWeekEven: Bool
}

private func makeCalendarDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    decoder.dateDecodingStrategy = .formatted(formatter)
    return decoder
}

func fetchAcademicCalendar() async -> AcademicCalendar? {
    let defaults = UserDefaults.standard
    let urlString = "\(WidgetConfig.mainRestApiUrl)/academic_calendars"
    
    guard let url = URL(string: urlString) else {
        return loadCachedCalendar(from: defaults)
    }
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            let apiResponse = try makeCalendarDecoder().decode(AcademicCalendarResponse.self, from: data)
            if let calendar = apiResponse.data.first {
                defaults.set(data, forKey: "cached_academic_calendar")
                return calendar
            }
        }
    } catch {
        print("CountdownWidget: fetch error: \(error)")
    }
    
    return loadCachedCalendar(from: defaults)
}

func loadCachedCalendar(from defaults: UserDefaults) -> AcademicCalendar? {
    guard let data = defaults.data(forKey: "cached_academic_calendar") else { return nil }
    return try? makeCalendarDecoder().decode(AcademicCalendarResponse.self, from: data).data.first
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CountdownHomeWidgetEntry {
        CountdownHomeWidgetEntry(
            date: Date(),
            daysLeft: 12,
            counterMessage: "do rozpoczęcia sesji",
            daysLabel: "dni",
            error: nil
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (CountdownHomeWidgetEntry) -> Void) {
        completion(placeholder(in: context))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CountdownHomeWidgetEntry>) -> Void) {
        Task {
            let calendarData = await fetchAcademicCalendar()
            
            let entry: CountdownHomeWidgetEntry
            if let calendar = calendarData {
                let now = Date()
                let isPl = Locale.current.identifier.hasPrefix("pl")
                
                let holidays = now < calendar.semesterStartDate || now > calendar.examSessionLastDate
                let examSession = now >= calendar.examSessionStartDate && now <= calendar.examSessionLastDate
                
                let targetDate: Date
                if holidays {
                    targetDate = calendar.semesterStartDate
                } else if examSession {
                    targetDate = calendar.examSessionLastDate
                } else {
                    targetDate = calendar.examSessionStartDate
                }
                
                let calendarObj = Calendar.current
                let startOfToday = calendarObj.startOfDay(for: now)
                let startOfTarget = calendarObj.startOfDay(for: targetDate)
                let daysLeft = max(0, calendarObj.dateComponents([.day], from: startOfToday, to: startOfTarget).day ?? 0)
                
                let counterMessage: String
                if holidays {
                    counterMessage = isPl ? "do końca przerwy międzysemestralnej" : "until the end of the semester break"
                } else if examSession {
                    counterMessage = isPl ? "do zakończenia sesji" : "until the session ends"
                } else {
                    counterMessage = isPl ? "do rozpoczęcia sesji" : "until the session starts"
                }
                
                let daysLabel = isPl ? "dni" : "days"
                
                entry = CountdownHomeWidgetEntry(
                    date: now,
                    daysLeft: daysLeft,
                    counterMessage: counterMessage,
                    daysLabel: daysLabel,
                    error: nil
                )
            } else {
                entry = CountdownHomeWidgetEntry(
                    date: Date(),
                    daysLeft: nil,
                    counterMessage: nil,
                    daysLabel: nil,
                    error: calendarData == nil ? "Network connection error" : "Calendar format error"
                )
            }
            
            // Reload at midnight to update the day counter, or in 15 minutes on failure
            let calendar = Calendar.current
            let nextUpdate: Date
            if entry.error != nil {
                nextUpdate = Date().addingTimeInterval(900) // Retry in 15 mins on error
            } else {
                let midnight = calendar.startOfDay(for: Date())
                nextUpdate = calendar.date(byAdding: .day, value: 1, to: midnight) ?? Date().addingTimeInterval(86400)
            }
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct CountdownHomeWidgetEntry: TimelineEntry {
    let date: Date
    let daysLeft: Int?
    let counterMessage: String?
    let daysLabel: String?
    let error: String?
}

struct AppColors {
    static let mirageDark = Color(red: 0x29/255.0, green: 0x32/255.0, blue: 0x41/255.0)
    static let soapWhite = Color(red: 0xFF/255.0, green: 0xFD/255.0, blue: 0xFC/255.0)
    static let pigeonGrey = Color(red: 0x76/255.0, green: 0x85/255.0, blue: 0x9D/255.0)
    static let trendRed = Color(red: 0xDC/255.0, green: 0x35/255.0, blue: 0x45/255.0)
}

struct CountdownHomeWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let isDark = colorScheme == .dark
        let textColor = isDark ? AppColors.soapWhite : AppColors.mirageDark

        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("ToPWR")
                    .font(.system(size: 11, weight: .black, design: .rounded))
                    .foregroundColor(textColor)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(textColor)
                    .font(.system(size: 12))
            }
            
            Spacer(minLength: 0)
            
            if let error = entry.error {
                Text("Error")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(textColor)
                Text(error)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(textColor)
            } else if let days = entry.daysLeft,
                      let message = entry.counterMessage,
                      let label = entry.daysLabel {
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(String(format: "%03d", days))
                        .font(.system(size: 38, weight: .heavy, design: .rounded))
                        .foregroundColor(textColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Text(label)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(textColor)
                        .lineLimit(1)
                }
                
                Spacer(minLength: 0)
                
                Text(message)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundColor(textColor.opacity(0.85))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text("Loading...")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(textColor)
            }
        }
    }
}

struct CountdownHomeWidget: Widget {
    let kind: String = "CountdownHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CountdownHomeWidgetEntryView(entry: entry)
                .applyContainerBackground()
        }
        .configurationDisplayName("Dni do sesji")
        .description("Licznik dni do sesji lub kolejnego semestru.")
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
