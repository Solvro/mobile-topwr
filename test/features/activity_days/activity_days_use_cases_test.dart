import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/config/env.dart";
import "package:topwr/features/activity_days/business/activity_days_stands_use_case.dart";
import "package:topwr/features/activity_days/business/activity_days_timetable_use_case.dart";
import "package:topwr/features/activity_days/data/models/activity_days_response.dart";
import "package:topwr/features/activity_days/data/models/activity_days_stand_response.dart";
import "package:topwr/features/activity_days/data/models/activity_days_stands_response.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_media_repository.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_repository.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_stands_repository.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_timetable_repository.dart";
import "package:topwr/features/activity_days/presentation/activity_days_stand_detail_view.dart";
import "package:topwr/features/activity_days/presentation/widgets/map_tile.dart";
import "package:topwr/features/feature_codes/data/feature_codes_repository.dart";
import "package:topwr/l10n/app_localizations.dart";
import "package:topwr/widgets/my_html_widget.dart";
import "package:topwr/widgets/wide_tile_card.dart";

void main() {
  group("Activity Days visibility", () {
    final now = DateTime(2026, 10, 17, 12);
    final expired = ActivityDaysResponse(
      id: 1,
      name: "Expired DAS",
      startsAt: now.subtract(const Duration(days: 4)),
      endsAt: now.subtract(const Duration(days: 2)),
      createdAt: now.subtract(const Duration(days: 5)),
      updatedAt: now.subtract(const Duration(days: 3)),
    );
    final latestExpired = ActivityDaysResponse(
      id: 2,
      name: "Latest expired DAS",
      startsAt: now.subtract(const Duration(days: 2)),
      endsAt: now.subtract(const Duration(days: 1)),
      createdAt: now.subtract(const Duration(days: 3)),
      updatedAt: now.subtract(const Duration(days: 2)),
    );

    test("does not select expired DAS without preview access", () {
      final event = selectActivityDaysEvent([expired, latestExpired], now: now, includeExpired: false);

      expect(event, isNull);
    });

    test("selects the latest expired DAS with preview access", () {
      final event = selectActivityDaysEvent([expired, latestExpired], now: now, includeExpired: true);

      expect(event, latestExpired);
    });

    test("prefers a running DAS over expired DAS with preview access", () {
      final running = ActivityDaysResponse(
        id: 3,
        name: "Running DAS",
        startsAt: now.subtract(const Duration(hours: 1)),
        endsAt: now.add(const Duration(hours: 1)),
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now,
      );

      final event = selectActivityDaysEvent([expired, running], now: now, includeExpired: true);

      expect(event, running);
    });
  });

  group("isActivityDaysActive", () {
    final now = DateTime.now();
    final running = ActivityDaysResponse(
      id: 3,
      name: "Running DAS",
      startsAt: now.subtract(const Duration(hours: 1)),
      endsAt: now.add(const Duration(hours: 1)),
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now,
    );
    final upcoming = ActivityDaysResponse(
      id: 4,
      name: "Upcoming DAS",
      startsAt: now.add(const Duration(days: 1)),
      endsAt: now.add(const Duration(days: 2)),
      createdAt: now,
      updatedAt: now,
    );
    final expired = ActivityDaysResponse(
      id: 1,
      name: "Expired DAS",
      startsAt: now.subtract(const Duration(days: 4)),
      endsAt: now.subtract(const Duration(days: 2)),
      createdAt: now.subtract(const Duration(days: 5)),
      updatedAt: now.subtract(const Duration(days: 3)),
    );

    ProviderContainer createContainer({
      required ISet<String> featureCodes,
      required ActivityDaysResponse? selectedEvent,
    }) {
      return ProviderContainer(
        overrides: [
          featureCodesRepositoryProvider.overrideWithValue(featureCodes),
          activityDaysRepositoryProvider.overrideWith((ref) => Future.value(selectedEvent)),
        ],
      );
    }

    test("is active for a running event without preview access", () async {
      final container = createContainer(featureCodes: const ISetConst({}), selectedEvent: running);
      addTearDown(container.dispose);

      expect(await container.read(isActivityDaysActiveProvider.future), isTrue);
    });

    test("is inactive for an upcoming event without preview access", () async {
      final container = createContainer(featureCodes: const ISetConst({}), selectedEvent: upcoming);
      addTearDown(container.dispose);

      expect(await container.read(isActivityDaysActiveProvider.future), isFalse);
    });

    test("is active for an upcoming event with preview access", () async {
      final container = createContainer(
        featureCodes: ISetConst({Env.activityDaysFeatureCode}),
        selectedEvent: upcoming,
      );
      addTearDown(container.dispose);

      expect(await container.read(isActivityDaysActiveProvider.future), isTrue);
    });

    test("is active for an expired event with preview access", () async {
      final container = createContainer(featureCodes: ISetConst({Env.activityDaysFeatureCode}), selectedEvent: expired);
      addTearDown(container.dispose);

      expect(await container.read(isActivityDaysActiveProvider.future), isTrue);
    });

    test("is inactive for an expired event without preview access", () async {
      final container = createContainer(featureCodes: const ISetConst({}), selectedEvent: expired);
      addTearDown(container.dispose);

      expect(await container.read(isActivityDaysActiveProvider.future), isFalse);
    });

    test("is inactive when no event is selected", () async {
      final container = createContainer(featureCodes: ISetConst({Env.activityDaysFeatureCode}), selectedEvent: null);
      addTearDown(container.dispose);

      expect(await container.read(isActivityDaysActiveProvider.future), isFalse);
    });
  });

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
          "logoKey": "organization-logo-key",
          "studentOrganization": {"id": 1392, "name": "Robocik"},
        },
        "logo": null,
      },
    });

    expect(response.data.floor?.name, "Ground floor");
    expect(response.data.dasOrganization?.logoKey, "organization-logo-key");
    expect(response.data.dasOrganization?.studentOrganization?.id, 1392);
  });

  test("parses a map content key when the API does not populate its image", () {
    final response = ActivityDaysListResponse.fromJson({
      "data": [
        {
          "id": 1,
          "name": "DAS",
          "startsAt": "2026-09-19T10:00:00.000Z",
          "endsAt": "2026-09-20T10:00:00.000Z",
          "createdAt": "2026-09-01T10:00:00.000Z",
          "updatedAt": "2026-09-01T10:00:00.000Z",
          "maps": [
            {"id": 1, "name": "Ground floor", "contentKey": "map-content-key"},
          ],
        },
      ],
    });

    final map = response.data.single.maps.single;
    expect(map.image, isNull);
    expect(map.contentKey, "map-content-key");
  });

  test("uses stand logo before organization logo and falls back to organization logo", () {
    const standLogo = ImageData(url: "stand-logo");
    const organizationLogo = ImageData(url: "organization-logo");
    const organization = DasOrganization(id: 7, name: "Robotics club", logo: organizationLogo, logoKey: "logo-key");

    const standWithOwnLogo = DasStand(
      id: 1,
      dasId: 1,
      number: "A1",
      name: "Robotics",
      logo: standLogo,
      dasOrganization: organization,
    );
    const standWithoutOwnLogo = DasStand(
      id: 2,
      dasId: 1,
      number: "A2",
      name: "Robotics",
      dasOrganization: organization,
    );

    expect(standWithOwnLogo.effectiveLogo, standLogo);
    expect(standWithoutOwnLogo.effectiveLogo, organizationLogo);
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
    expect(find.byType(MyHtmlWidget), findsNWidgets(2));
    final organizationCard = tester.widget<WideTileCard>(find.byType(WideTileCard, skipOffstage: false));
    expect(organizationCard.title, "Robotics club");
    expect(organizationCard.subtitle, "Student robotics organization");
    expect(organizationCard.crossAxisAlignment, CrossAxisAlignment.center);
    expect(organizationCard.fixedTrailingHeight, isFalse);
    expect(organizationCard.contentPadding, const EdgeInsets.all(16));
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

  testWidgets("map media failures can be retried", (tester) async {
    var attempts = 0;
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          activityDaysFileImageProvider("missing-map").overrideWith((ref) {
            attempts++;
            throw StateError("missing map");
          }),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: MapTile(
                  map: ActivityDaysMap(id: 1, name: "Ground floor", contentKey: "missing-map"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(attempts, 1);
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    expect(attempts, 2);
  });
}
