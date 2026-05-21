import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:topwr/config/env.dart";
import "package:topwr/features/booths/data/models/booth.dart";
import "package:topwr/features/booths/data/repository/booths_repository.dart";
import "package:topwr/features/booths/presentation/booths_view.dart";
import "package:topwr/features/feature_codes/data/feature_codes_repository.dart";
import "package:topwr/features/navigation_tab_view/navigation_tab_view.dart";
import "package:topwr/l10n/app_localizations.dart";
import "package:topwr/theme/app_theme.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("quiet booths are enabled from default feature codes and open correctly", (tester) async {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: "ToPWR",
      packageName: "pl.solvro.topwr",
      version: "1.2.44",
      buildNumber: "132",
      buildSignature: "test",
    );

    final container = ProviderContainer(
      overrides: [
        boothsRepositoryProvider.overrideWith((ref) => Future.value(_testBooths)),
        defaultFeatureCodesProvider.overrideWith((ref) => IListConst([Env.boothFeatureCode])),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(featureCodesRepositoryProvider), contains(Env.boothFeatureCode));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale("pl"),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: const AppTheme().light,
          home: const NavigationTabView(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final boothsTile = find.text("Strefy wyciszenia");
    expect(boothsTile, findsOneWidget);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale("pl"),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: const AppTheme().light,
          home: const BoothsView(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(BoothsView), findsOneWidget);
    expect(find.text(_testBooths.first.name), findsOneWidget);
  });
}

final _testBooths = IList<Booth>(const [
  Booth(
    id: "quiet-booth-1",
    name: "Strefa 11.C",
    photoUrl: "",
    localization: "Biblioteka, 1 pietro",
    isOccupied: null,
    reportedAt: null,
    isOnline: false,
  ),
]);
