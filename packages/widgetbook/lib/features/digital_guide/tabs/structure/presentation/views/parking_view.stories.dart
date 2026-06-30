import "package:topwr/features/digital_guide/tabs/structure/data/models/parking.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/parking_view.dart";
import "package:widgetbook/widgetbook.dart";

part "parking_view.stories.g.dart";

const _mockParkingDg = DigitalGuideParking(
  translations: DigitalGuideParkingTranslations(
    plTranslation: DigitalGuideParkingTranslation(
      entryLocation: "North entrance",
      isEntryFromGroundLevelComment: "Wjazd znajduje się na poziomie terenu, bez rampy.",
      isSetMaximumVehicleHeightComment: "Maksymalna wysokość pojazdu: 2.1 m.",
      areSpacesForPwdComment: "Wyznaczono miejsca dla osób z niepełnosprawnością blisko wejścia.",
      areSpacesForPwdVerticalMarkedComment: "Miejsca oznaczono pionowo i poziomo.",
      isRoadAccessibleForPeopleInWheelchairsComment: "Droga do wejścia prowadzi utwardzonym chodnikiem.",
      isMultistoreyParkingComment: "Parking jednopoziomowy.",
      comment: "W godzinach szczytu zalecany wcześniejszy przyjazd.",
    ),
  ),
  id: 1,
  orderNumber: 1,
  isEntryFromGroundLevel: "yes",
  isSetMaximumVehicleHeight: "no",
  permissionsTypes: "studenci, pracownicy",
  areSpacesForPwd: "yes",
  areSpacesForPwdVerticalMarked: "yes",
  isRoadAccessibleForPeopleInWheelchairs: "yes",
  shortestLengthToNearestSpacesForPwd: 12,
  isMultistoreyParking: "no",
  building: 1,
);

const meta = Meta(ParkingView.new);

final $default = ParkingViewStory(args: ParkingViewArgs(parking: Arg.fixed(_mockParkingDg)));
