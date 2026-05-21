@Timeout(Duration(minutes: 15))
library;

import "package:drift/drift.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:topwr/config/env.dart";
import "package:topwr/config/nav_bar_config.dart";
import "package:topwr/config/ui_config.dart";
import "package:topwr/features/app_changelog/data/repository/local_changelog_repository.dart";
import "package:topwr/features/booths/data/models/booth.dart";
import "package:topwr/features/booths/data/repository/booths_repository.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/data/repository/branch_repository.dart";
import "package:topwr/features/feature_codes/data/feature_codes_repository.dart";
import "package:topwr/main.dart" as app;
import "package:topwr/services/translations_service/data/preferred_lang_repository.dart";

class _MockPreferredLanguageRepository extends PreferredLanguageRepository {
  @override
  Future<SolvroLocale?> build() {
    return Future.value(SolvroLocale.pl);
  }
}

class _MockBranchRepository extends BranchRepository {
  @override
  Future<Branch?> build() {
    return Future.value(Branch.main);
  }
}

class _MockLocalChangelogRepository extends LocalChangelogRepository {
  @override
  Future<bool?> build(String appVersion) {
    return Future.value(true);
  }
}

final _testBooths = IList<Booth>([
  Booth(
    id: "quiet-booth-1",
    name: "Strefa 11.C",
    photoUrl: "",
    localization: "Biblioteka, 1 pietro",
    isOccupied: false,
    reportedAt: DateTime.utc(2026, 5, 21, 10, 15),
    isOnline: true,
  ),
]);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  List<Override> overrides() {
    return [
      preferredLanguageRepositoryProvider.overrideWith(_MockPreferredLanguageRepository.new),
      branchRepositoryProvider.overrideWith(_MockBranchRepository.new),
      localChangelogRepositoryProvider.overrideWith(_MockLocalChangelogRepository.new),
      defaultFeatureCodesProvider.overrideWith((ref) => IListConst([Env.boothFeatureCode])),
      boothsRepositoryProvider.overrideWith((ref) => Future.value(_testBooths)),
    ];
  }

  Future<void> tapNavButton(WidgetTester tester, NavBarEnum e) async {
    await tester.tap(find.byKey(Key(e.name)));
  }

  testWidgets("Quiet booths are available from default feature codes", (tester) async {
    await app.main(overrides: overrides());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tapNavButton(tester, NavBarEnum.navigation);
    await tester.pump(const Duration(seconds: 3));

    final boothsTile = find.text("Strefy wyciszenia");
    expect(boothsTile, findsOneWidget);

    await tester.scrollUntilVisible(boothsTile, 50, scrollable: find.byKey(MyAppConfig.verticalScrollableKey));
    await tester.tap(boothsTile);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(_testBooths.first.name), findsOneWidget);
  });
}
