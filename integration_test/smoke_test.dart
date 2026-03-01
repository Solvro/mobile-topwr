import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:topwr/config/nav_bar_config.dart";
import "package:topwr/config/ui_config.dart";
import "package:topwr/features/app_changelog/data/repository/local_changelog_repository.dart";
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

class MockBranchRepository extends BranchRepository {
  @override
  Future<Branch?> build() {
    return Future.value(Branch.main);
  }
}

class MockLocalChangelogRepository extends LocalChangelogRepository {
  @override
  Future<bool?> build(String appVersion) {
    return Future.value(true);
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
        fail("Test przerwany: Znaleziono widget, którego miało nie być!");
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

  testWidgets("Popup flow test", (tester) async {
    await app.main();
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

    final errorFinder = find.byType(MyErrorWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(errorFinder, findsNothing);
  });

  testWidgets("HomeView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tapNavButton(tester, NavBarEnum.home);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });

  testWidgets("BuildingsView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.buildings);
    await tester.pumpAndSettle();

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });

  testWidgets("ParkingsView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.parkings);
    await tester.pumpAndSettle();

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });

  testWidgets("GuideView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.guide);
    await tester.pumpAndSettle();

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });

  // testWidgets("NavigationView smoke test", (tester) async {
  //   await app.main(overrides: createPopupProviderOverrides());
  //   await tester.pumpAndSettle();

  //   await tapNavButton(tester, NavBarEnum.navigation);
  //   await tester.pumpAndSettle();

  //   final errorFinder = find.byType(MyErrorWidget);
  //   final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
  //   await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
  //   await tester.pumpAndSettle();
  // });

  testWidgets("BuildingsView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.navigation);
    await tester.pumpAndSettle();

    final navButton = find.byKey(NavigationTabViewConfig.departments);
    await tester.tap(navButton);

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });

  testWidgets("ScienceClubView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.navigation);
    await tester.pumpAndSettle();

    final navButton = find.byKey(NavigationTabViewConfig.scienceClubsKey);
    await tester.tap(navButton);

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });

  testWidgets("RadioLuzView smoke test", (tester) async {
    await app.main(overrides: createPopupProviderOverrides());
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.navigation);
    await tester.pumpAndSettle();

    final navButton = find.byKey(NavigationTabViewConfig.radioLuzKey);
    await tester.tap(navButton);

    final errorFinder = find.byType(MyErrorWidget);
    final scrollableFinder = find.byKey(MyAppConfig.verticalScrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();
  });
}
