import "package:topwr/features/digital_guide/tabs/structure/data/models/parking.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/parking_view.dart";
import "package:widgetbook/widgetbook.dart";

part "parking_view.stories.g.dart";

const _mockParkingDg = DigitalGuideParking(
  translations: DigitalGuideParkingTranslations(
    plTranslation: DigitalGuideParkingTranslation(
      entryLocation: "North entrance",
      isEntryFromGroundLevelComment: "",
      isSetMaximumVehicleHeightComment: "",
      areSpacesForPwdComment: "",
      areSpacesForPwdVerticalMarkedComment: "",
      isRoadAccessibleForPeopleInWheelchairsComment: "",
      isMultistoreyParkingComment: "",
      comment: "",
    ),
  ),
  id: 1,
  orderNumber: 1,
  isEntryFromGroundLevel: "yes",
  isSetMaximumVehicleHeight: "no",
  permissionsTypes: "",
  areSpacesForPwd: "yes",
  areSpacesForPwdVerticalMarked: "yes",
  isRoadAccessibleForPeopleInWheelchairs: "yes",
  shortestLengthToNearestSpacesForPwd: 12,
  isMultistoreyParking: "no",
  building: 1,
);

const meta = Meta<ParkingView>();

final $default = ParkingViewStory(args: ParkingViewArgs(parking: Arg.fixed(_mockParkingDg)));
