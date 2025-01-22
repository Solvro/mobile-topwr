import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../rooms/data/models/digital_guide_room.dart";
import "corridor.dart";
import "dressing_room.dart";
import "information_point.dart";
import "lift.dart";
import "lodge.dart";
import "parking.dart";
import "ramp.dart";
import "stairs.dart";
import "stairway.dart";
import "toilet.dart";

typedef RegionData = ({
  IList<Corridor> corridors,
  IList<Stairs> stairs,
  IList<Ramp> ramps,
  IList<Stairway> stairways,
  IList<Lift> lifts,
  IList<Lodge> lodges,
  IList<InformationPoint> informationPoints,
  IList<DressingRoom> dressingRooms,
  IList<Toilet> toilets,
  IList<DigitalGuideRoom> rooms,
  IList<Parking> parkings,
});
