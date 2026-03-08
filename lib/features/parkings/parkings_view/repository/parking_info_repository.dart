import "package:riverpod_annotation/riverpod_annotation.dart";

import "../models/parking_info.dart";

part "parking_info_repository.g.dart";

@riverpod
Future<ParkingInfo> parkingInfoRepository(Ref ref) async {
  return const ParkingInfo(
    message:
        "Parkingi zlokalizowane przy ul. Hoene-Wrońskiego oraz w Pasażu Studenckim są ogólnodostępne dla pracowników, doktorantów i studentów PWr od poniedziałku do piątku w godzinach 17:00-22:30, a także przez cały weekend.\n\nW weekendy do dyspozycji pracowników, doktorantów i studentów PWr pozostaje również parking w budynku C-18 (Strefa Kultury Studenckiej).",
  );
}
