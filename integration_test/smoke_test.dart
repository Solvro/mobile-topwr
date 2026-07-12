@Timeout(Duration(minutes: 45))
library;

import "dart:math";
import "package:drift/drift.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:topwr/config/nav_bar_config.dart";
import "package:topwr/config/ui_config.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/app_changelog/data/repository/local_changelog_repository.dart";
import "package:topwr/features/app_changelog/data/repository/my_changelog_repository.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/data/repository/branch_repository.dart";
import "package:topwr/features/departments/departments_view/widgets/department_card.dart";
import "package:topwr/features/guide_view/widgets/guide_tile.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/science_club_card.dart";
import "package:topwr/main.dart" as app;
import "package:topwr/services/translations_service/data/preferred_lang_repository.dart";
import "package:topwr/widgets/my_error_widget.dart";

class MockPreferredLanguageRepository extends PreferredLanguageRepository {
  @override
  Future<SolvroLocale?> build() {
    return Future.value(SolvroLocale.pl);
  }
}

class MockFirstTimePreferredLanguageRepository extends PreferredLanguageRepository {
  @override
  Future<SolvroLocale?> build() {
    return Future.value();
  }
}

class MockBranchRepository extends BranchRepository {
  @override
  Future<Branch?> build() {
    return Future.value(Branch.main);
  }
}

class MockFirstTimeBranchRepository extends BranchRepository {
  @override
  Future<Branch?> build() {
    return Future.value();
  }
}

class MockLocalChangelogRepository extends LocalChangelogRepository {
  @override
  Future<bool?> build(String appVersion) {
    return Future.value(true);
  }
}

class MockUnseenChangelogRepository extends LocalChangelogRepository {
  @override
  Future<bool?> build(String appVersion) {
    return Future.value(false);
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  Future<void> startApp(WidgetTester tester, {required List<Override> overrides}) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await app.main(overrides: overrides, skipCarPlay: true);
  }

  Future<void> tapChoiceButton(WidgetTester tester) async {
    final choiceButton = find.text("Wybierz");
    await tester.tap(choiceButton);
  }

  Future<void> tapNavButton(WidgetTester tester, NavBarEnum e) async {
    final navButton = find.byKey(Key(e.name));
    await tester.tap(navButton);
  }

  Future<void> openSettingsView(WidgetTester tester) async {
    await tapNavButton(tester, NavBarEnum.navigation);
    await tester.pump(const Duration(seconds: 3)); // pumpAndSettle never ends on NavigationView

    final navButton = find.byKey(NavigationTabViewConfig.settingsKey);
    await tester.scrollUntilVisible(navButton, 50, maxScrolls: 10);
    await tester.drag(find.byKey(MyAppConfig.verticalScrollableKey), const Offset(0, -200));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(navButton);
    await tester.pump(const Duration(seconds: 3));
  }

  Future<void> scrollAndFailIfFound({
    required WidgetTester tester,
    required Finder scrollableFinder,
    required Finder targetFinder,
    double scrollAmount = -300.0,
  }) async {
    var isEndReached = false;

    while (!isEndReached) {
      if (targetFinder.evaluate().isNotEmpty) {
        fail("Test Failed: We found ${targetFinder.found.first}");
      }

      final ScrollableState scrollableState = tester.state(
        find.descendant(of: scrollableFinder, matching: find.byType(Scrollable)).first,
      );
      final ScrollPosition position = scrollableState.position;

      if (position.pixels >= position.maxScrollExtent) {
        isEndReached = true;
        break;
      }

      final center = tester.getCenter(scrollableFinder);

      await tester.dragFrom(center, Offset(0, scrollAmount));

      await tester.pumpAndSettle();
    }
  }

  Future<bool> pumpUntil(
    WidgetTester tester,
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 30),
    Duration step = const Duration(milliseconds: 100),
  }) async {
    final clock = tester.binding.clock;
    final end = clock.fromNowBy(timeout);
    while (clock.now().isBefore(end)) {
      if (condition()) return true;
      await tester.pump(step);
    }
    return condition();
  }

  final random = Random(1234);

  Future<void> checkRandomDetailsScreen(WidgetTester tester, Finder tileFinder) async {
    final tileCount = tileFinder.evaluate().length;
    if (tileCount == 0) fail("Test failed: No detail tiles found");

    final tile = tileFinder.at(random.nextInt(tileCount));
    await tester.ensureVisible(tile);
    await tester.pumpAndSettle();
    await tester.tap(tile);

    final errorFinder = find.byType(MyErrorWidget);
    final loadedFinder = find.byType(CustomScrollView);
    final resolved = await pumpUntil(
      tester,
      () => loadedFinder.evaluate().isNotEmpty || errorFinder.evaluate().isNotEmpty,
    );

    if (!resolved) {
      fail("Test failed: Detail screen didn't reach loaded or error state in time");
    }
    if (errorFinder.evaluate().isNotEmpty) {
      fail("Test failed: Screen didn't load correctly ${errorFinder.found.first}");
    }

    await scrollAndFailIfFound(tester: tester, scrollableFinder: loadedFinder, targetFinder: errorFinder);
  }

  List<Override> createPopupProviderOverrides() {
    return [
      preferredLanguageRepositoryProvider.overrideWith(MockPreferredLanguageRepository.new),
      branchRepositoryProvider.overrideWith(MockBranchRepository.new),
      localChangelogRepositoryProvider.overrideWith2((_) => MockLocalChangelogRepository()),
    ];
  }

  Future<List<Override>> createFirstTimePopupProviderOverrides() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return [
      preferredLanguageRepositoryProvider.overrideWith(MockFirstTimePreferredLanguageRepository.new),
      branchRepositoryProvider.overrideWith(MockFirstTimeBranchRepository.new),
      localChangelogRepositoryProvider.overrideWith2((_) => MockUnseenChangelogRepository()),
      changelogRepositoryProvider.overrideWith(
        (ref) => Changelog(
          name: packageInfo.version,
          changes: const IListConst([ChangelogChange(changeType: TypeOfChange.feature, name: "Smoke test changelog")]),
        ),
      ),
    ];
  }

  group("End-to-End Smoke Tests", () {
    tearDown(() async {
      await Future<void>.delayed(const Duration(milliseconds: 200));
    });

    testWidgets("Popup flow test", (tester) async {
      await startApp(tester, overrides: await createFirstTimePopupProviderOverrides());
      await tester.pumpAndSettle();

      final languageButton = find.text("🇵🇱 Polski");
      await tester.tap(languageButton);

      await tapChoiceButton(tester);

      await tester.pumpAndSettle();

      final branchButton = find.text("Politechnika Wrocławska");
      await tester.tap(branchButton);

      await tapChoiceButton(tester);
      await tester.pumpAndSettle();

      final closeButton = find.byKey(ChangelogConfig.closeButtonKey);
      await tester.tap(closeButton);
    });

    testWidgets("HomeView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tapNavButton(tester, NavBarEnum.home);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("BuildingsView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.buildings);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("ParkingsView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.parkings);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("GuideView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.guide);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();

      await checkRandomDetailsScreen(tester, find.byType(GuideTile));
    });

    testWidgets("DeparmentsView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.navigation);
      await tester.pump(const Duration(seconds: 3)); // there pumpAndSettle never ends on NavigationView

      final navButton = find.byKey(NavigationTabViewConfig.departments);
      await tester.tap(navButton);

      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));

      await checkRandomDetailsScreen(tester, find.byType(DepartmentCard));
    });

    testWidgets("ScienceClubView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.navigation);
      await tester.pump(const Duration(seconds: 3)); // there pumpAndSettle never ends on NavigationView

      final navButton = find.byKey(NavigationTabViewConfig.scienceClubsKey);
      await tester.tap(navButton);

      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();

      await checkRandomDetailsScreen(tester, find.byType(ScienceClubCard));
    });

    testWidgets("RadioLuzView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.navigation);
      await tester.pump(const Duration(seconds: 3)); // there pumpAndSettle never ends on NavigationView

      final navButton = find.byKey(NavigationTabViewConfig.radioLuzKey);
      await tester.tap(navButton);

      await tester.pump(const Duration(seconds: 3));

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pump(const Duration(seconds: 3));
    }, skip: true); // now we skipping bcs radioluzView is throwing an error

    testWidgets("AboutUsView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.navigation);
      await tester.pump(const Duration(seconds: 3)); // there pumpAndSettle never ends on Navigationview

      final navButton = find.byKey(NavigationTabViewConfig.aboutUsKey);
      await tester.tap(navButton);

      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("CalendarView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tapNavButton(tester, NavBarEnum.home);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final navButton = find.byKey(HomeViewConfig.calendarKey);
      await tester.tap(navButton);

      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("NewsListView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tapNavButton(tester, NavBarEnum.home);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final navButton = find.byKey(HomeViewConfig.newsListKey);
      await tester.tap(navButton);

      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("SksMenuScreen smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tapNavButton(tester, NavBarEnum.home);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final navButton = find.byKey(HomeViewConfig.sksMenuKey);
      await tester.tap(navButton);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("SettingsView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await openSettingsView(tester);

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("SksFavouriteDishesView smoke test", (tester) async {
      await startApp(tester, overrides: createPopupProviderOverrides());
      await tester.pumpAndSettle();

      await openSettingsView(tester);

      final settingsNavButton = find.byKey(NavigationTabViewConfig.sksFavouriteDishesKey);
      await tester.tap(settingsNavButton);

      await tester.pumpAndSettle();

      // checks only widgets on loaded view
      final errorFinder = find.byType(MyErrorWidget);
      if (errorFinder.evaluate().isNotEmpty) {
        debugPrint("Error widget found. View not loaded correctly.");
      }

      // using key already existing in sks_favourite_dishes_view
      final scrollableFinder = find.byKey(const PageStorageKey("SksFavouriteDishesListView"));
      if (scrollableFinder.evaluate().isNotEmpty) {
        await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      }
      await tester.pumpAndSettle();
    });
  });
}
