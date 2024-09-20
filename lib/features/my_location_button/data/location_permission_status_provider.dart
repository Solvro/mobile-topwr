import "package:permission_handler/permission_handler.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "location_permission_status_provider.g.dart";

@riverpod
Future<bool> locationPermissionStatus(LocationPermissionStatusRef ref) async {
  var status = await Permission.location.status;
  if (!status.isGranted) {
    status = await Permission.location.request();
  }
  return status.isGranted;
}
