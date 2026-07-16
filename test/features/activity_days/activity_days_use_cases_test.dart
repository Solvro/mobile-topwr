import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:topwr/features/activity_days/business/activity_days_stands_use_case.dart";
import "package:topwr/features/activity_days/business/activity_days_timetable_use_case.dart";
import "package:topwr/features/activity_days/data/models/activity_days_response.dart";
import "package:topwr/features/activity_days/data/models/activity_days_stand_response.dart";
import "package:topwr/features/activity_days/data/models/activity_days_stands_response.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_stands_repository.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_timetable_repository.dart";
import "package:topwr/features/activity_days/presentation/activity_days_stand_detail_view.dart";
import "package:topwr/l10n/app_localizations.dart";
import "package:topwr/widgets/wide_tile_card.dart";

void main() {
  group("Activity Days stands", () {
    test("groups stands by floor, sorts stands, and puts missing floor last", () async {
      const groundFloor = DasFloor(id: 1, name: "Ground floor");
      final stands = [
        const DasStand(id: 3, dasId: 1, number: "B3", name: "Third", floor: groundFloor, floorId: 1),
        const DasStand(id: 2, dasId: 1, number: "A1", name: "Second", floor: groundFloor, floorId: 1),
        const DasStand(id: 1, dasId: 1, number: "QA-0", name: "No floor"),
      ].lock;
      final container = ProviderContainer(overrides: [dasStandsRepositoryProvider.overrideWith((ref) => stands)]);
      addTearDown(container.dispose);

      final floors = await container.read(dasStandsByFloorUseCaseProvider.future);

      expect(floors.map((floor) => floor.floor?.name), ["Ground floor", null]);
      expect(floors.first.stands.map((stand) => stand.number), ["A1", "B3"]);
    });
  });

  group("Activity Days timetable", () {
    test("groups and sorts entries while preserving a missing end time", () async {
      final entries = [
        ActivityDaysTimetableEntry(id: 3, name: "Day two", startTime: DateTime(2026, 7, 18, 10)),
        ActivityDaysTimetableEntry(id: 2, name: "Later", startTime: DateTime(2026, 7, 17, 14)),
        ActivityDaysTimetableEntry(
          id: 1,
          name: "Earlier",
          startTime: DateTime(2026, 7, 17, 9),
          endTime: DateTime(2026, 7, 17, 10, 30),
        ),
      ].lock;
      final container = ProviderContainer(
        overrides: [activityDaysTimetableRepositoryProvider.overrideWith((ref) => entries)],
      );
      addTearDown(container.dispose);

      final days = await container.read(activityDaysTimetableUseCaseProvider.future);

      expect(days.map((day) => day.date), [DateTime(2026, 7, 17), DateTime(2026, 7, 18)]);
      expect(days.first.events.map((event) => event.name), ["Earlier", "Later"]);
      expect(days.first.events.map((event) => event.hoursString), ["09:00 - 10:30", "14:00"]);
    });
  });

  test("parses stand details with optional linked organization", () {
    final response = DasStandResponse.fromJson({
      "data": {
        "id": 1,
        "dasId": 1,
        "number": "A1",
        "name": "Robotics",
        "description": "Robots",
        "floorId": 1,
        "floor": {"id": 1, "name": "Ground floor"},
        "dasOrganization": {
          "id": 7,
          "name": "Robotics club",
          "studentOrganization": {"id": 1392, "name": "Robocik"},
        },
        "logo": null,
      },
    });

    expect(response.data.floor?.name, "Ground floor");
    expect(response.data.dasOrganization?.studentOrganization?.id, 1392);
  });

  testWidgets("stand details render optional content and organization action", (tester) async {
    const stand = DasStand(
      id: 1,
      dasId: 1,
      number: "A1",
      name: "Robotics",
      description: "Mobile robots",
      floorId: 1,
      floor: DasFloor(id: 1, name: "Ground floor"),
      dasOrganization: DasOrganization(
        id: 7,
        name: "Robotics club",
        description: "Student robotics organization",
        studentOrganization: DasStudentOrganization(id: 1392, name: "Robocik"),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [dasStandRepositoryProvider(1).overrideWith((ref) => stand)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ActivityDaysStandDetailView(id: 1),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Robotics"), findsOneWidget);
    expect(find.text("Stand A1"), findsOneWidget);
    expect(find.text("Ground floor"), findsOneWidget);
    expect(find.text("Mobile robots"), findsOneWidget);
    final organizationCard = tester.widget<WideTileCard>(find.byType(WideTileCard, skipOffstage: false));
    expect(organizationCard.title, "Robotics club");
    expect(organizationCard.subtitle, "Student robotics organization");
  });

  test("stand fields fall back to its DAS organization", () {
    const stand = DasStand(
      id: 1,
      dasId: 1,
      number: "A1",
      name: "",
      description: " ",
      dasOrganization: DasOrganization(id: 7, name: "Organization name", description: "Organization description"),
    );

    expect(stand.effectiveName, "Organization name");
    expect(stand.effectiveDescription, "Organization description");
  });
}
