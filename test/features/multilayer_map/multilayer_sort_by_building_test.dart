import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:test/test.dart";

import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/aed.dart";
import "package:topwr/features/multilayer_map/data/model/bicycle_shower.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/library.dart";
import "package:topwr/features/multilayer_map/data/model/pink_box.dart";
import "package:topwr/features/multilayer_map/data/utils/utils.dart";

void main() {
  const buildingA1 = Building(
    rawId: 1,
    name: "A-1",
    naturalName: null,
    addressLine1: "Address A1",
    addressLine2: null,
    latitude: 51,
    longitude: 17,
    externalDigitalGuideMode: null,
    externalDigitalGuideIdOrUrl: null,
    cover: null,
    branch: Branch.main,
  );
  const buildingA2 = Building(
    rawId: 2,
    name: "A-2",
    naturalName: null,
    addressLine1: "Address A2",
    addressLine2: null,
    latitude: 51.1,
    longitude: 17.1,
    externalDigitalGuideMode: null,
    externalDigitalGuideIdOrUrl: null,
    cover: null,
    branch: Branch.main,
  );
  const buildingB1 = Building(
    rawId: 3,
    name: "B-1",
    naturalName: null,
    addressLine1: "Address B1",
    addressLine2: null,
    latitude: 51.2,
    longitude: 17.2,
    externalDigitalGuideMode: null,
    externalDigitalGuideIdOrUrl: null,
    cover: null,
    branch: Branch.main,
  );

  test("sortByAssociatedBuilding orders libraries by building code, then raw id", () {
    final libraries = [
      const Library(
        rawId: 10,
        title: "Library B1",
        room: "101",
        latitude: 51.21,
        longitude: 17.21,
        building: buildingB1,
        branch: Branch.main,
      ),
      const Library(
        rawId: 11,
        title: "Library A2",
        room: "201",
        latitude: 51.11,
        longitude: 17.11,
        building: buildingA2,
        branch: Branch.main,
      ),
      const Library(
        rawId: 12,
        title: "Library A1",
        room: "102",
        latitude: 51.01,
        longitude: 17.01,
        building: buildingA1,
        branch: Branch.main,
      ),
      const Library(
        rawId: 13,
        title: "Library without building",
        room: null,
        latitude: 51.31,
        longitude: 17.31,
        branch: Branch.main,
      ),
      const Library(
        rawId: 9,
        title: "Earlier library A1",
        room: "100",
        latitude: 51,
        longitude: 17,
        building: buildingA1,
        branch: Branch.main,
      ),
      const Library(
        rawId: 8,
        title: "Earlier library without building",
        room: null,
        latitude: 51.32,
        longitude: 17.32,
        branch: Branch.main,
      ),
    ].toIList();

    final sortedLibraries = libraries.sortByAssociatedBuilding(
      buildingOf: (library) => library.building,
      tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
    );

    expect(sortedLibraries.map((library) => library.rawId).toList(), [9, 12, 11, 10, 8, 13]);
  });

  test("sortByAssociatedBuilding orders AEDs by building code, then raw id", () {
    final aeds = [
      const Aed(
        rawId: 20,
        latitude: 51.2,
        longitude: 17.2,
        photo: null,
        addressLine1: "Line 1",
        addressLine2: null,
        instructions: "B1",
        building: buildingB1,
        branch: Branch.main,
      ),
      const Aed(
        rawId: 21,
        latitude: 51,
        longitude: 17,
        photo: null,
        addressLine1: "Line 2",
        addressLine2: null,
        instructions: "A1",
        building: buildingA1,
        branch: Branch.main,
      ),
      const Aed(
        rawId: 22,
        latitude: 51.1,
        longitude: 17.1,
        photo: null,
        addressLine1: "Line 3",
        addressLine2: null,
        instructions: "A2",
        building: buildingA2,
        branch: Branch.main,
      ),
      const Aed(
        rawId: 23,
        latitude: 51.3,
        longitude: 17.3,
        photo: null,
        addressLine1: "Line 4",
        addressLine2: null,
        instructions: null,
        branch: Branch.main,
      ),
      const Aed(
        rawId: 19,
        latitude: 51,
        longitude: 17,
        photo: null,
        addressLine1: "Line 0",
        addressLine2: null,
        instructions: "Earlier A1",
        building: buildingA1,
        branch: Branch.main,
      ),
      const Aed(
        rawId: 18,
        latitude: 51.31,
        longitude: 17.31,
        photo: null,
        addressLine1: "Line 5",
        addressLine2: null,
        instructions: null,
        branch: Branch.main,
      ),
    ].toIList();

    final sortedAeds = aeds.sortByAssociatedBuilding(
      buildingOf: (aed) => aed.building,
      tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
    );

    expect(sortedAeds.map((aed) => aed.rawId).toList(), [19, 21, 22, 20, 18, 23]);
  });

  test("sortByAssociatedBuilding orders showers by building code, then raw id", () {
    final showers = [
      const BicycleShower(
        rawId: 30,
        room: "Room B1",
        instructions: "B1",
        latitude: 51.2,
        longitude: 17.2,
        building: buildingB1,
        branch: Branch.main,
      ),
      const BicycleShower(
        rawId: 31,
        room: "Room A2",
        instructions: "A2",
        latitude: 51.1,
        longitude: 17.1,
        building: buildingA2,
        branch: Branch.main,
      ),
      const BicycleShower(
        rawId: 32,
        room: "Room A1",
        instructions: "A1",
        latitude: 51,
        longitude: 17,
        building: buildingA1,
        branch: Branch.main,
      ),
      const BicycleShower(
        rawId: 33,
        room: null,
        instructions: null,
        latitude: 51.3,
        longitude: 17.3,
        branch: Branch.main,
      ),
      const BicycleShower(
        rawId: 29,
        room: "Earlier room A1",
        instructions: "Earlier A1",
        latitude: 51,
        longitude: 17,
        building: buildingA1,
        branch: Branch.main,
      ),
      const BicycleShower(
        rawId: 28,
        room: null,
        instructions: null,
        latitude: 51.31,
        longitude: 17.31,
        branch: Branch.main,
      ),
    ].toIList();

    final sortedShowers = showers.sortByAssociatedBuilding(
      buildingOf: (shower) => shower.building,
      tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
    );

    expect(sortedShowers.map((shower) => shower.rawId).toList(), [29, 32, 31, 30, 28, 33]);
  });

  test("sortByAssociatedBuilding orders pink boxes by building code, then raw id", () {
    final pinkBoxes = [
      const PinkBox(
        rawId: 40,
        roomOrNearby: "B1",
        latitude: 51.2,
        longitude: 17.2,
        building: buildingB1,
        branch: Branch.main,
      ),
      const PinkBox(
        rawId: 41,
        roomOrNearby: "A2",
        latitude: 51.1,
        longitude: 17.1,
        building: buildingA2,
        branch: Branch.main,
      ),
      const PinkBox(
        rawId: 42,
        roomOrNearby: "A1",
        latitude: 51,
        longitude: 17,
        building: buildingA1,
        branch: Branch.main,
      ),
      const PinkBox(rawId: 43, roomOrNearby: null, latitude: 51.3, longitude: 17.3, branch: Branch.main),
      const PinkBox(
        rawId: 39,
        roomOrNearby: "Earlier A1",
        latitude: 51,
        longitude: 17,
        building: buildingA1,
        branch: Branch.main,
      ),
      const PinkBox(rawId: 38, roomOrNearby: null, latitude: 51.31, longitude: 17.31, branch: Branch.main),
    ].toIList();

    final sortedPinkBoxes = pinkBoxes.sortByAssociatedBuilding(
      buildingOf: (pinkBox) => pinkBox.building,
      tieBreaker: (a, b) => a.rawId.compareTo(b.rawId),
    );

    expect(sortedPinkBoxes.map((pinkBox) => pinkBox.rawId).toList(), [39, 42, 41, 40, 38, 43]);
  });
}
