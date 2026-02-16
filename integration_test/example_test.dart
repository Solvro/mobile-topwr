import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";

import "package:topwr/main.dart" as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Prosty test bez Patrola", (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final languageButton = find.byKey(const Key("language_choice_pl"));
    await tester.tap(languageButton);

    await tester.pumpAndSettle();

    print("Widzisz to na emulatorze!");

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
  });
}
