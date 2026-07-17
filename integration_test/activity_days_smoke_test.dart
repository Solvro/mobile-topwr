@Timeout(Duration(minutes: 15))
library;

import "package:drift/drift.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:topwr/config/ui_config.dart";
import "package:topwr/features/activity_days/data/models/activity_days_response.dart";
import "package:topwr/features/activity_days/data/models/activity_days_stands_response.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_repository.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_stands_repository.dart";
import "package:topwr/features/activity_days/data/repository/activity_days_timetable_repository.dart";
import "package:topwr/features/activity_days/presentation/activity_days_stand_detail_view.dart";
import "package:topwr/features/activity_days/presentation/activity_days_view.dart";
import "package:topwr/features/app_changelog/data/repository/local_changelog_repository.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/data/repository/branch_repository.dart";
import "package:topwr/main.dart" as app;
import "package:topwr/services/translations_service/data/preferred_lang_repository.dart";
import "package:topwr/widgets/my_error_widget.dart";
import "package:topwr/widgets/wide_tile_card.dart";

class _MockPreferredLanguageRepository extends PreferredLanguageRepository {
  @override
  Future<SolvroLocale?> build() => Future.value(SolvroLocale.pl);
}

class _MockBranchRepository extends BranchRepository {
  @override
  Future<Branch?> build() => Future.value(Branch.main);
}

class _MockLocalChangelogRepository extends LocalChangelogRepository {
  @override
  Future<bool?> build(String appVersion) => Future.value(true);
}

final _activityDaysEvent = ActivityDaysResponse(
  id: 1,
  name: "Testowe DAS",
  startsAt: DateTime.now().subtract(const Duration(hours: 1)),
  endsAt: DateTime.now().add(const Duration(days: 2)),
  createdAt: DateTime.now().subtract(const Duration(days: 30)),
  updatedAt: DateTime.now(),
);

const _activityDaysStand = DasStand(
  id: 1,
  dasId: 1,
  number: "A1",
  name: "Koło Naukowe Robotyki",
  description: "Prezentacja robotów mobilnych.",
  floorId: 1,
  floor: DasFloor(id: 1, name: "Parter (C-13)"),
  dasOrganization: DasOrganization(
    id: 1,
    name: "KN Robocik",
    description: "Koło Naukowe Automatyki i Robotyki",
    studentOrganization: DasStudentOrganization(id: 1392, name: "Robocik"),
  ),
);

final _activityDaysEntries = IList([
  ActivityDaysTimetableEntry(
    id: 1,
    name: "Otwarcie DAS",
    startTime: DateTime.now().add(const Duration(hours: 1)),
    endTime: DateTime.now().add(const Duration(hours: 2)),
  ),
  ActivityDaysTimetableEntry(
    id: 2,
    name: "Warsztaty",
    startTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
  ),
]);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  List<Override> overrides() => [
    preferredLanguageRepositoryProvider.overrideWith(_MockPreferredLanguageRepository.new),
    branchRepositoryProvider.overrideWith(_MockBranchRepository.new),
    localChangelogRepositoryProvider.overrideWith2((_) => _MockLocalChangelogRepository()),
    isActivityDaysActiveProvider.overrideWith((ref) => true),
    activityDaysRepositoryProvider.overrideWith((ref) => _activityDaysEvent),
    activityDaysTimetableRepositoryProvider.overrideWith((ref) => _activityDaysEntries),
    dasStandsRepositoryProvider.overrideWith((ref) => const IListConst([_activityDaysStand])),
    dasStandRepositoryProvider.overrideWith((ref, id) => _activityDaysStand),
  ];

  Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
    final end = tester.binding.clock.fromNowBy(const Duration(seconds: 10));
    while (tester.binding.clock.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 100));
      if (tester.any(finder)) return;
    }
  }

  testWidgets("Activity Days tabs and stand details load", (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await app.main(overrides: overrides(), skipCarPlay: true);

    final activityDaysButton = find.byKey(HomeViewConfig.activityDaysKey);
    await pumpUntilFound(tester, activityDaysButton);
    expect(activityDaysButton, findsOneWidget);
    await tester.tap(activityDaysButton);

    await pumpUntilFound(tester, find.byType(ActivityDaysView));
    expect(find.byType(ActivityDaysView), findsOneWidget);
    expect(find.byType(MyErrorWidget), findsNothing);
    expect(find.byType(PhotoTrailingWideTileCard), findsOneWidget);

    await tester.tap(find.text("Harmonogram"));
    await tester.pumpAndSettle();
    expect(find.text("Otwarcie DAS"), findsOneWidget);
    expect(find.text("Warsztaty"), findsOneWidget);

    await tester.tap(find.text("Stoiska"));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PhotoTrailingWideTileCard));

    await pumpUntilFound(tester, find.byType(ActivityDaysStandDetailView));
    expect(find.byType(ActivityDaysStandDetailView), findsOneWidget);
    expect(find.text(_activityDaysStand.name), findsOneWidget);
    expect(find.text(_activityDaysStand.description!), findsOneWidget);
    expect(find.byType(MyErrorWidget), findsNothing);
  });
}
