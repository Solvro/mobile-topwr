import "package:connectivity_plus/connectivity_plus.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "has_internet_connection.g.dart";

@riverpod
Stream<bool> hasInternetConnection(Ref ref) async* {
  final connectivity = Connectivity();

  final init = await connectivity.checkConnectivity();
  yield init.first != ConnectivityResult.none;
  if (init.first != ConnectivityResult.none) {
    return;
  }

  await for (final status in connectivity.onConnectivityChanged) {
    final isOnline = status.first != ConnectivityResult.none;
    yield isOnline;

    if (isOnline) {
      break;
    }
  }
}
