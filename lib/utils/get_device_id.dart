import "dart:convert";
import "dart:io";
import "package:android_id/android_id.dart";
import "package:crypto/crypto.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

@Riverpod(keepAlive: true)
Future<String?> getDeviceId() async {
  String? deviceId;
  if (Platform.isIOS) {
    final iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    deviceId = await const AndroidId().getId();
  }
  if (deviceId != null) {
    final bytes = utf8.encode(deviceId);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  return null;
}
