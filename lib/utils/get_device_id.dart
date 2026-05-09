import "dart:convert";
import "dart:io";

import "package:android_id/android_id.dart";
import "package:crypto/crypto.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "get_device_id.g.dart";

@Riverpod(keepAlive: true)
Future<String?> getDeviceId(Ref ref) async {
  if (kIsWeb) {
    final webInfo = await DeviceInfoPlugin().webBrowserInfo;
    final fingerprint = [
      webInfo.userAgent,
      webInfo.vendor,
      webInfo.platform,
      webInfo.hardwareConcurrency,
      webInfo.maxTouchPoints,
      webInfo.language,
    ].join("|");
    final bytes = utf8.encode(fingerprint);
    return sha256.convert(bytes).toString();
  }

  String? deviceId;
  if (Platform.isIOS) {
    final iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    deviceId = await const AndroidId().getId();
  }
  if (deviceId != null) {
    final bytes = utf8.encode(deviceId);
    return sha256.convert(bytes).toString();
  }
  return null;
}
