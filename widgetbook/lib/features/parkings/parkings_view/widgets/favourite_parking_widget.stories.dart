import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_favourite.dart";
import "package:widgetbook/widgetbook.dart";

part "favourite_parking_widget.stories.g.dart";

const _productionParking = Parking(
  id: "2",
  parkingId: "2",
  numberOfPlaces: "55",
  symbol: "C13",
  type: "O",
  name: "Polinka",
  openHour: "00:00:00",
  closeHour: "00:00:00",
  places: "54",
  geoLan: "17.06094",
  geoLat: "51.10804",
  photo: "https://parking-api.topwr.solvro.pl/images/parkings/original/C13.jpg",
  miniaturePhoto: "https://parking-api.topwr.solvro.pl/images/parkings/miniatures/C13.jpg",
  active: "1",
  showPark: "1",
  lp: "",
  address: "wybrzeże Stanisława Wyspiańskiego 25",
  trend: "0",
  access: ParkingAccess.students,
);

const meta = Meta<FavouriteParkingWidget>();

final $default = FavouriteParkingWidgetStory(args: FavouriteParkingWidgetArgs(parking: Arg.fixed(_productionParking)));
