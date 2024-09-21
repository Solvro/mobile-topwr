import "package:permission_handler/permission_handler.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "location_permission_status_provider.g.dart";

@riverpod
class LocationPermissionStatus extends _$LocationPermissionStatus {
  @override
  FutureOr<bool> build() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  Future<bool> request() async {
    final isAlreadyGranted = state.value ?? true;
    if (!isAlreadyGranted) {
      final newStat = await Permission.location.request();
      state = AsyncData(newStat.isGranted);
    }
    return state.value ?? false;
  }
}
