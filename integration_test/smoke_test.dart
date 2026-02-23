import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:topwr/config/nav_bar_config.dart";
import "package:topwr/config/ui_config.dart";

import "package:topwr/main.dart" as app;
import "package:topwr/widgets/my_error_widget.dart";

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

  testWidgets("Smoke test", (tester) async {
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
    final scrollableFinder = find.byKey(MyAppConfig.scrollableKey);
    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);
    await tester.pumpAndSettle();

    await tapNavButton(tester, NavBarEnum.buildings);
    await tester.pumpAndSettle();

    await scrollAndFailIfFound(tester: tester, scrollableFinder: scrollableFinder, targetFinder: errorFinder);

    await tapNavButton(tester, NavBarEnum.parkings);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 3));

    await tapNavButton(tester, NavBarEnum.guide);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 3));
  });
}
