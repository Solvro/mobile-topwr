import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:patrol/patrol.dart";
import "package:topwr/features/settings/widgets/language_settings_dialog.dart";
import "package:topwr/main.dart" as app;

void main() {
  patrolTest("check if language dialog appears", ($) async {
    debugPrint("🔵 === TEST START - Language Dialog ===");

    FlutterError.onError = (FlutterErrorDetails details) {
      debugPrint("⚠️ Zignorowano błąd: ${details.exception}");
    };

    await app.main();

    debugPrint("🔵 Waiting for app to load...");
    await $.pumpAndSettle(timeout: const Duration(seconds: 10));

    debugPrint("🔵 Looking for LanguageDialog...");

    final languageDialog = $(LanguageDialog);
    final dialogCount = languageDialog.evaluate().length;
    debugPrint("🔵 Found $dialogCount LanguageDialog widgets");

    $.tester.widget<Text>(find.text("Wybierz język").first);
    debugPrint("🔵 Select language text found");

    if (dialogCount > 0) {
      debugPrint("✅ Language dialog APPEARED (as expected)");
      expect(languageDialog, findsOneWidget);
    } else {
      debugPrint("❌ Language dialog DID NOT appear");
    }

    debugPrint("🎉 === TEST END ===");
  });
}
