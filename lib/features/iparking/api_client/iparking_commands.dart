import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'iparking_client.dart';

class FetchPlacesCommand extends DelegatingMap {
  FetchPlacesCommand(DateTime timestamp)
      : super({
          "o": "get_parks",
          // "ts": "1665147767564"
          "ts": timestamp.millisecondsSinceEpoch.toString()
        });
}

class FetchChartCommand extends DelegatingMap {
  FetchChartCommand(String index)
      : super({
          "o": "get_today_chart",
          "i": index,
        });
}

extension IParkingCommands on AutoDisposeRef {
  Future<dynamic> postIParkingCommand(Map command) {
    return watch(iParkingClientProvider).post("", data: command);
  }
}
