import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/parking.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/parking_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ParkingView)
Widget useCaseParkingView(BuildContext context) {
  // Mock data for DigitalGuideParking
  const parking = DigitalGuideParking(
    translations: DigitalGuideParkingTranslations(
      plTranslation: DigitalGuideParkingTranslation(
        entryLocation: "Main entrance near building A",
        isEntryFromGroundLevelComment: "Entry is at ground level.",
        isSetMaximumVehicleHeightComment: "Max height is 2.2 meters.",
        areSpacesForPwdComment: "There are 4 accessible spaces.",
        areSpacesForPwdVerticalMarkedComment: "All accessible spaces are vertically marked.",
        isRoadAccessibleForPeopleInWheelchairsComment: "Path is smooth and wheelchair accessible.",
        isMultistoreyParkingComment: "Not a multistorey parking lot.",
        comment: "Open 24/7. Parking is under CCTV surveillance.",
      ),
    ),
    id: 1,
    orderNumber: 10,
    isEntryFromGroundLevel: "yes",
    isSetMaximumVehicleHeight: "yes",
    permissionsTypes: "public",
    areSpacesForPwd: "yes",
    areSpacesForPwdVerticalMarked: "yes",
    isRoadAccessibleForPeopleInWheelchairs: "yes",
    shortestLengthToNearestSpacesForPwd: 12.5,
    isMultistoreyParking: "no",
    building: 3,
  );
  return const ParkingView(parking: parking);
}
