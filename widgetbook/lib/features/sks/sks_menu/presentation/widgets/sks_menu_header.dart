import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_opening_hours.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_header.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksMenuHeader)
Widget useCaseSksMenuHeader(BuildContext context) {
  return SksMenuHeader(
    dateTimeOfLastUpdate: context.knobs.string(label: "DateTime of Last Update"),
    isMenuOnline: context.knobs.boolean(label: "Is Menu Online", initialValue: true),
    openingHours: context.knobs.object.dropdown(
      label: "Opening Hours",
      options: [
        const OpeningHours(
          canteen: VenueHours(openingTime: "08:00", closingTime: "16:00"),
          cafe: VenueHours(openingTime: "08:00", closingTime: "16:00"),
        ),
        const OpeningHours(
          canteen: VenueHours(openingTime: "09:00", closingTime: "17:00"),
          cafe: VenueHours(openingTime: "09:00", closingTime: "17:00"),
        ),
        const OpeningHours(
          canteen: VenueHours(openingTime: "10:00", closingTime: "18:00"),
          cafe: VenueHours(openingTime: "10:00", closingTime: "18:00"),
        ),
      ],
    ),
  );
}
