import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_wide_tile_card.dart";
import "package:topwr/l10n/app_localizations.dart";

void main() {
  testWidgets("parking remains usable when its thumbnail fails to load", (tester) async {
    SharedPreferences.setMockInitialValues({});
    var tapped = false;

    // Widget tests return HTTP 400 for network images, so this exercises the
    // image failure path without depending on the live parking API.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ParkingWideTileCard(parking: _parking, isActive: false, onTap: () => tapped = true),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text("SKS"), findsOneWidget);
    expect(find.text("10"), findsOneWidget);

    await tester.tap(find.text("SKS"));
    expect(tapped, isTrue);
  });
}

const _parking = Parking(
  id: "1",
  parkingId: "1",
  numberOfPlaces: "10",
  symbol: "SKS",
  type: null,
  name: "SKS",
  openHour: null,
  closeHour: null,
  places: "10",
  geoLan: "17.03",
  geoLat: "51.11",
  photo: "https://example.invalid/missing-parking.jpg",
  active: "1",
  showPark: "1",
  lp: "1",
  address: "",
  trend: "0",
  access: ParkingAccess.all,
);
