import "package:collection/collection.dart";
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "iparking_client.dart";

class FetchPlacesCommand extends DelegatingMap {
  FetchPlacesCommand(DateTime timestamp) : super({"o": "get_parks", "ts": timestamp.millisecondsSinceEpoch.toString()});
}

class FetchChartCommand extends DelegatingMap {
  FetchChartCommand(String index) : super({"o": "get_today_chart", "i": index});
}

class ParkingsOfflineException implements Exception {}

extension IParkingCommandsX on Ref {
  Future<Response<T>> postIParkingCommand<T>(Map command) async {
    try {
      return await watch(iParkingClientProvider).post("", data: command);
    } on DioException catch (_) {
      await Future.delayed(const Duration(milliseconds: 300));
      throw ParkingsOfflineException();
    }
  }
}
