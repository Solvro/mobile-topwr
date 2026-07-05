import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:topwr/features/booths/data/models/booth.dart";
import "package:topwr/features/booths/data/repository/booths_repository.dart";
import "package:topwr/features/booths/presentation/booths_view.dart";
import "package:topwr/features/navigation_tab_view/navigation_tab_view.dart";
import "package:topwr/features/remote_config/data/models/remote_config.dart";
import "package:topwr/features/remote_config/data/repository/remote_config_repository.dart";
import "package:topwr/l10n/app_localizations.dart";
import "package:topwr/theme/app_theme.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("quiet booths are enabled from remote config and open correctly", (tester) async {
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
        remoteConfigRepositoryProvider.overrideWith((ref) => Future.value(_remoteConfigWithBooths)),
      ],
    );
    addTearDown(container.dispose);

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

  testWidgets("quiet booths are hidden when disabled in remote config", (tester) async {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: "ToPWR",
      packageName: "pl.solvro.topwr",
      version: "1.2.44",
      buildNumber: "132",
      buildSignature: "test",
    );

    final container = ProviderContainer(
      overrides: [remoteConfigRepositoryProvider.overrideWith((ref) => Future.value(_remoteConfigWithoutBooths))],
    );
    addTearDown(container.dispose);

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

    expect(find.text("Strefy wyciszenia"), findsNothing);
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

const _remoteConfigWithBooths = RemoteConfig(
  cmsReferenceNumber: 0,
  daySwapLookahead: 7,
  translatorReferenceNumber: 0,
  boothsApiBaseUrl: "https://booths-api.topwr.solvro.pl/api/v1",
  boothsEnabled: true,
);

const _remoteConfigWithoutBooths = RemoteConfig(
  cmsReferenceNumber: 0,
  daySwapLookahead: 7,
  translatorReferenceNumber: 0,
  boothsApiBaseUrl: "https://booths-api.topwr.solvro.pl/api/v1",
);
