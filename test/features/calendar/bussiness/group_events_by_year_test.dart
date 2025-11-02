import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:test/test.dart";

import "package:topwr/features/calendar/bussiness/get_events_per_days_use_case.dart";
import "package:topwr/features/calendar/data/model/calendar_data.dart";
import "package:topwr/l10n/app_localizations.dart";
import "package:topwr/l10n/app_localizations_pl.dart";

void main() {
  late AppLocalizations l10n;

  setUp(() {
    l10n = AppLocalizationsPl();
  });

  group("groupEventsByYear", () {
    test("should return empty list when events list is empty", () {
      final events = <CalendarData>[].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result, isEmpty);
    });

    test("should group single event by year correctly", () {
      const event = CalendarData(
        id: 1,
        name: "Test Event",
        startTime: "2024-01-15T10:00:00",
        endTime: "2024-01-15T12:00:00",
        location: "Test Location",
        description: "Test Description",
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 1);
      expect(result.first.year, 2024);
      expect(result.first.events.length, 1); // January
      expect(result.first.events.first.month, 1);
      expect(result.first.events.first.events.length, 1); // Day 15
      expect(result.first.events.first.events.first.day, 15);
      expect(result.first.events.first.events.first.events.length, 1);
      expect(result.first.events.first.events.first.events.first.name, "Test Event");
    });

    test("should group multiple events in the same year correctly", () {
      const event1 = CalendarData(
        id: 1,
        name: "Event 1",
        startTime: "2024-01-15T10:00:00",
        endTime: "2024-01-15T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event2 = CalendarData(
        id: 2,
        name: "Event 2",
        startTime: "2024-03-20T14:00:00",
        endTime: "2024-03-20T16:00:00",
        location: "Location 2",
        description: "Description 2",
        accentColor: null,
      );
      final events = [event1, event2].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 1);
      expect(result.first.year, 2024);
      expect(result.first.events.length, 2); // January and March
      expect(result.first.events.map((e) => e.month).toList(), [1, 3]);
    });

    test("should group events across different years correctly", () {
      const event2023 = CalendarData(
        id: 1,
        name: "Event 2023",
        startTime: "2023-12-31T10:00:00",
        endTime: "2023-12-31T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event2024 = CalendarData(
        id: 2,
        name: "Event 2024",
        startTime: "2024-01-01T10:00:00",
        endTime: "2024-01-01T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event2025 = CalendarData(
        id: 3,
        name: "Event 2025",
        startTime: "2025-06-15T10:00:00",
        endTime: "2025-06-15T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event2024, event2025, event2023].toIList(); // Out of order

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 3);
      expect(result.map((e) => e.year).toList(), [2023, 2024, 2025]); // Should be sorted
      expect(result[0].year, 2023);
      expect(result[1].year, 2024);
      expect(result[2].year, 2025);
    });

    test("should handle multi-day events correctly", () {
      const multiDayEvent = CalendarData(
        id: 1,
        name: "Multi-day Event",
        startTime: "2024-01-15T10:00:00",
        endTime: "2024-01-17T12:00:00",
        location: "Conference Center",
        description: "A 3-day conference",
        accentColor: null,
      );
      final events = [multiDayEvent].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 1);
      expect(result.first.year, 2024);
      expect(result.first.events.length, 1); // January
      expect(result.first.events.first.month, 1);
      expect(result.first.events.first.events.length, 3); // Days 15, 16, 17
      expect(result.first.events.first.events.map((e) => e.day).toList(), [15, 16, 17]);
    });

    test("should handle events spanning multiple months", () {
      const crossMonthEvent = CalendarData(
        id: 1,
        name: "Cross-month Event",
        startTime: "2024-01-30T10:00:00",
        endTime: "2024-02-02T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [crossMonthEvent].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 1);
      expect(result.first.year, 2024);
      expect(result.first.events.length, 2); // January and February
      expect(result.first.events.map((e) => e.month).toList(), [1, 2]);
    });

    test("should handle events spanning multiple years", () {
      const crossYearEvent = CalendarData(
        id: 1,
        name: "Cross-year Event",
        startTime: "2023-12-30T10:00:00",
        endTime: "2024-01-02T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [crossYearEvent].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 2); // Should appear in both years
      expect(result.map((e) => e.year).toList(), [2023, 2024]);

      // Event should appear in December 2023
      final year2023 = result.firstWhere((e) => e.year == 2023);
      expect(year2023.events.any((m) => m.month == 12), true);

      // Event should appear in January 2024
      final year2024 = result.firstWhere((e) => e.year == 2024);
      expect(year2024.events.any((m) => m.month == 1), true);
    });

    test("should sort years in ascending order", () {
      const event1 = CalendarData(
        id: 1,
        name: "Event 2025",
        startTime: "2025-01-01T10:00:00",
        endTime: "2025-01-01T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event2 = CalendarData(
        id: 2,
        name: "Event 2023",
        startTime: "2023-01-01T10:00:00",
        endTime: "2023-01-01T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event3 = CalendarData(
        id: 3,
        name: "Event 2024",
        startTime: "2024-01-01T10:00:00",
        endTime: "2024-01-01T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event1, event2, event3].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 3);
      expect(result[0].year, 2023);
      expect(result[1].year, 2024);
      expect(result[2].year, 2025);
    });

    test("should preserve event details correctly", () {
      const event = CalendarData(
        id: 42,
        name: "Important Meeting",
        startTime: "2024-06-15T09:30:00",
        endTime: "2024-06-15T11:45:00",
        location: "Room 101",
        description: "Quarterly review meeting",
        accentColor: "#E43D32",
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      final calendarItem = result.first.events.first.events.first.events.first;
      expect(calendarItem.name, "Important Meeting");
      expect(calendarItem.location, "Room 101");
      expect(calendarItem.description, "Quarterly review meeting");
      expect(calendarItem.hoursString, "09:30 - 11:45");
      expect(calendarItem.accentColor, isNotNull);
      expect(calendarItem.accentColor!.hexString, "#E43D32");
    });

    test("should handle multiple events on the same day", () {
      const event1 = CalendarData(
        id: 1,
        name: "Morning Meeting",
        startTime: "2024-05-10T09:00:00",
        endTime: "2024-05-10T10:00:00",
        location: "Room A",
        description: null,
        accentColor: null,
      );
      const event2 = CalendarData(
        id: 2,
        name: "Afternoon Workshop",
        startTime: "2024-05-10T14:00:00",
        endTime: "2024-05-10T17:00:00",
        location: "Room B",
        description: "Technical workshop",
        accentColor: null,
      );
      const event3 = CalendarData(
        id: 3,
        name: "Evening Event",
        startTime: "2024-05-10T18:00:00",
        endTime: "2024-05-10T20:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event1, event2, event3].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 1);
      expect(result.first.year, 2024);
      final dayEvents = result.first.events.firstWhere((m) => m.month == 5).events.firstWhere((d) => d.day == 10);
      expect(dayEvents.events.length, 3);
      expect(dayEvents.events.map((e) => e.name).toList(), ["Morning Meeting", "Afternoon Workshop", "Evening Event"]);
    });

    test("should handle events with all null optional fields", () {
      const event = CalendarData(
        id: 1,
        name: "Event Without Details",
        startTime: "2024-07-20T12:00:00",
        endTime: "2024-07-20T13:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      final calendarItem = result.first.events.first.events.first.events.first;
      expect(calendarItem.name, "Event Without Details");
      expect(calendarItem.location, "");
      expect(calendarItem.description, null);
    });

    test("should handle events at midnight boundary", () {
      const event = CalendarData(
        id: 1,
        name: "Midnight Event",
        startTime: "2024-08-15T00:00:00",
        endTime: "2024-08-15T23:59:59",
        location: "Everywhere",
        description: "Full day event",
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.first.year, 2024);
      final calendarItem = result.first.events
          .firstWhere((m) => m.month == 8)
          .events
          .firstWhere((d) => d.day == 15)
          .events
          .first;
      expect(calendarItem.name, "Midnight Event");
      expect(calendarItem.hoursString, "00:00 - 23:59");
    });

    test("should handle very long multi-day events", () {
      const longEvent = CalendarData(
        id: 1,
        name: "Conference Week",
        startTime: "2024-09-01T09:00:00",
        endTime: "2024-09-10T18:00:00",
        location: "Convention Center",
        description: "10-day conference",
        accentColor: null,
      );
      final events = [longEvent].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.first.year, 2024);
      final september = result.first.events.firstWhere((m) => m.month == 9);
      expect(september.events.length, 10); // Days 1-10
      expect(september.events.map((d) => d.day).toList(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

      // Verify multi-day format
      final firstDay = september.events.firstWhere((d) => d.day == 1);
      expect(firstDay.events.first.hoursString, contains("dzień 1/10"));
    });

    test("should handle leap year events correctly", () {
      const leapYearEvent = CalendarData(
        id: 1,
        name: "Leap Day Event",
        startTime: "2024-02-29T10:00:00",
        endTime: "2024-02-29T12:00:00",
        location: "Leap Location",
        description: "Only happens in leap years",
        accentColor: null,
      );
      final events = [leapYearEvent].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.first.year, 2024);
      final february = result.first.events.firstWhere((m) => m.month == 2);
      expect(february.events.any((d) => d.day == 29), true);
      final leapDay = february.events.firstWhere((d) => d.day == 29);
      expect(leapDay.events.first.name, "Leap Day Event");
    });

    test("should handle events with special characters in names", () {
      const event = CalendarData(
        id: 1,
        name: "Event: Special @ Characters #123 & More!",
        startTime: "2024-10-05T10:00:00",
        endTime: "2024-10-05T12:00:00",
        location: "Location with émojis 🎉",
        description: "Description with \"quotes\" and 'apostrophes'",
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      final calendarItem = result.first.events.first.events.first.events.first;
      expect(calendarItem.name, "Event: Special @ Characters #123 & More!");
      expect(calendarItem.location, "Location with émojis 🎉");
      expect(calendarItem.description, "Description with \"quotes\" and 'apostrophes'");
    });

    test("should handle events spanning exactly one year boundary", () {
      const yearBoundaryEvent = CalendarData(
        id: 1,
        name: "New Year Celebration",
        startTime: "2023-12-31T23:00:00",
        endTime: "2024-01-01T02:00:00",
        location: "Main Square",
        description: "Celebrating the new year",
        accentColor: null,
      );
      final events = [yearBoundaryEvent].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 2);
      expect(result.map((e) => e.year).toList(), [2023, 2024]);

      // Should appear in December 2023
      final dec2023 = result.firstWhere((y) => y.year == 2023).events.firstWhere((m) => m.month == 12);
      expect(dec2023.events.any((d) => d.day == 31), true);

      // Should appear in January 2024
      final jan2024 = result.firstWhere((y) => y.year == 2024).events.firstWhere((m) => m.month == 1);
      expect(jan2024.events.any((d) => d.day == 1), true);
    });

    test("should handle multiple events in the same month", () {
      const event1 = CalendarData(
        id: 1,
        name: "First of Month",
        startTime: "2024-11-01T10:00:00",
        endTime: "2024-11-01T11:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event2 = CalendarData(
        id: 2,
        name: "Middle of Month",
        startTime: "2024-11-15T14:00:00",
        endTime: "2024-11-15T15:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const event3 = CalendarData(
        id: 3,
        name: "End of Month",
        startTime: "2024-11-30T16:00:00",
        endTime: "2024-11-30T17:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event1, event2, event3].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.first.year, 2024);
      final november = result.first.events.firstWhere((m) => m.month == 11);
      expect(november.events.length, 3);
      expect(november.events.map((d) => d.day).toList(), [1, 15, 30]);
    });

    test("should handle events with empty string location", () {
      const event = CalendarData(
        id: 1,
        name: "Event with Empty Location",
        startTime: "2024-12-10T10:00:00",
        endTime: "2024-12-10T12:00:00",
        location: "",
        description: "Description exists",
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      final calendarItem = result.first.events.first.events.first.events.first;
      expect(calendarItem.location, "");
      expect(calendarItem.description, "Description exists");
    });

    test("should handle complex scenario with mixed event types", () {
      const singleDay = CalendarData(
        id: 1,
        name: "Single Day",
        startTime: "2024-03-05T10:00:00",
        endTime: "2024-03-05T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const multiDay = CalendarData(
        id: 2,
        name: "Multi Day",
        startTime: "2024-03-10T09:00:00",
        endTime: "2024-03-12T18:00:00",
        location: "Location",
        description: "Multi-day event",
        accentColor: null,
      );
      const crossMonth = CalendarData(
        id: 3,
        name: "Cross Month",
        startTime: "2024-03-31T10:00:00",
        endTime: "2024-04-02T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const sameDayMultiple = CalendarData(
        id: 4,
        name: "Same Day Event 1",
        startTime: "2024-03-15T08:00:00",
        endTime: "2024-03-15T10:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      const sameDayMultiple2 = CalendarData(
        id: 5,
        name: "Same Day Event 2",
        startTime: "2024-03-15T14:00:00",
        endTime: "2024-03-15T16:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [singleDay, multiDay, crossMonth, sameDayMultiple, sameDayMultiple2].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.length, 1);
      expect(result.first.year, 2024);
      expect(result.first.events.length, 2); // March and April

      final march = result.first.events.firstWhere((m) => m.month == 3);
      expect(march.events.length, 6); // Days: 5, 10, 11, 12, 15, 31
      expect(march.events.map((d) => d.day).toList(), [5, 10, 11, 12, 15, 31]);

      // Day 15 should have 2 events
      final day15 = march.events.firstWhere((d) => d.day == 15);
      expect(day15.events.length, 2);

      // Day 10, 11, 12 should have the multi-day event
      expect(march.events.any((d) => d.day == 10), true);
      expect(march.events.any((d) => d.day == 11), true);
      expect(march.events.any((d) => d.day == 12), true);

      final april = result.first.events.firstWhere((m) => m.month == 4);
      expect(april.events.length, 2); // Days 1, 2 from cross-month event
      expect(april.events.map((d) => d.day).toList(), [1, 2]);
    });

    test("should handle overnight events spanning multiple calendar days", () {
      const event = CalendarData(
        id: 1,
        name: "Overnight Event",
        startTime: "2024-04-15T22:00:00",
        endTime: "2024-04-16T02:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      expect(result.first.year, 2024);
      // Should appear on both calendar days (15 and 16)
      final april = result.first.events.firstWhere((m) => m.month == 4);
      expect(april.events.any((d) => d.day == 15), true);
      expect(april.events.any((d) => d.day == 16), true);
    });

    test("should handle events with very long descriptions", () {
      final longDescription = "A" * 1000; // Very long description
      final event = CalendarData(
        id: 1,
        name: "Event with Long Description",
        startTime: "2024-06-01T10:00:00",
        endTime: "2024-06-01T12:00:00",
        location: "Location",
        description: longDescription,
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      final calendarItem = result.first.events.first.events.first.events.first;
      expect(calendarItem.description, longDescription);
      expect(calendarItem.description!.length, 1000);
    });

    test("should maintain correct weekday for events", () {
      const event = CalendarData(
        id: 1,
        name: "Weekday Test",
        startTime: "2024-11-15T10:00:00", // November 15, 2024 is a Friday (weekday 5)
        endTime: "2024-11-15T12:00:00",
        location: null,
        description: null,
        accentColor: null,
      );
      final events = [event].toIList();

      final result = groupEventsByYear(events, l10n);

      final dayEvents = result.first.events.firstWhere((m) => m.month == 11).events.firstWhere((d) => d.day == 15);
      expect(dayEvents.weekday, 5); // Friday
    });
  });
}
