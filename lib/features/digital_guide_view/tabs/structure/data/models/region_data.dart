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

class RegionData{
  final IList<Corridor> corridors;
  final IList<Stairs> stairs;
  final IList<Ramp> ramps;
  final IList<Stairway> stairways;
  final IList<Lift> lifts;
  final IList<Lodge> lodges;
  final IList<InformationPoint> informationPoints;
  final IList<DressingRoom> dressingRooms;
  final IList<Toilet> toilets;
  final IList<DigitalGuideRoom> rooms;
  final IList<Parking> parkings;

  RegionData({
    required this.corridors,
    required this.stairs,
    required this.ramps,
    required this.stairways,
    required this.lifts,
    required this.lodges,
    required this.informationPoints,
    required this.dressingRooms,
    required this.toilets,
    required this.rooms,
    required this.parkings,
  });
}
