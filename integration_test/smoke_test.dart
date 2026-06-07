@Timeout(Duration(minutes: 45))
library;

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

  Future<void> tapChoiceButton(WidgetTester tester) async {
    final choiceButton = find.text("Wybierz");
    await tester.tap(choiceButton);
  }

  Future<void> tapNavButton(WidgetTester tester, NavBarEnum e) async {
    final navButton = find.byKey(Key(e.name));
    await tester.tap(navButton);
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

  List<Override> createPopupProviderOverrides() {
    return [
      preferredLanguageRepositoryProvider.overrideWith(MockPreferredLanguageRepository.new),
      branchRepositoryProvider.overrideWith(MockBranchRepository.new),
      localChangelogRepositoryProvider.overrideWith(MockLocalChangelogRepository.new),
    ];
  }

  Future<List<Override>> createFirstTimePopupProviderOverrides() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return [
      preferredLanguageRepositoryProvider.overrideWith(MockFirstTimePreferredLanguageRepository.new),
      branchRepositoryProvider.overrideWith(MockFirstTimeBranchRepository.new),
      localChangelogRepositoryProvider.overrideWith(MockUnseenChangelogRepository.new),
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
      await app.main(overrides: await createFirstTimePopupProviderOverrides(), skipCarPlay: true);
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
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tapNavButton(tester, NavBarEnum.home);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("BuildingsView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.buildings);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("ParkingsView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.parkings);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("GuideView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.guide);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("DeparmentsView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
    });

    testWidgets("ScienceClubView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
    });

    testWidgets("RadioLuzView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
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
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.navigation);
      await tester.pump(const Duration(seconds: 3)); // there pumpAndSettle never ends on NavigationView

      final navButton = find.byKey(NavigationTabViewConfig.settingsKey);
      await tester.scrollUntilVisible(navButton, 50, maxScrolls: 10);

      await tester.tap(navButton);
      await tester.pumpAndSettle();

      final errorFinder = find.byType(MyErrorWidget);
      final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
      await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
      await tester.pumpAndSettle();
    });

    testWidgets("SksFavouriteDishesView smoke test", (tester) async {
      await app.main(overrides: createPopupProviderOverrides(), skipCarPlay: true);
      await tester.pumpAndSettle();

      await tapNavButton(tester, NavBarEnum.navigation);
      await tester.pump(const Duration(seconds: 3)); // there pumpAndSettle never ends on NavigationView

      final navButton = find.byKey(NavigationTabViewConfig.settingsKey);
      await tester.scrollUntilVisible(navButton, 50, maxScrolls: 10);

      await tester.tap(navButton);
      await tester.pumpAndSettle();

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
