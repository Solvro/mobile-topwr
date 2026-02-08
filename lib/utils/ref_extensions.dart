import "dart:async";

import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../api_base_rest/client/dio_client.dart";
import "../config/env.dart";
import "get_device_id.dart";

extension RefIntervalRefreshX on Ref {
  void setRefresh(Duration interval) {
    final timer = Timer.periodic(interval, (t) => invalidateSelf());
    onDispose(timer.cancel);
  }
}

extension RefRegisterForNotificationsX on Ref {
  Future<String?> _getTokenSafe() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } on Exception {
      return null;
    }
  }

  Future<({String? deviceKey})> registerForNotifications() async {
    final client = read(restClientProvider);
    final url = "${Env.sksUrl}/device/registration-token";
    final deviceKey = await watch(getDeviceIdProvider.future);
    final registrationToken = await _getTokenSafe();
    if (deviceKey == null || registrationToken == null) {
      return (deviceKey: deviceKey);
    }
    await client.put<Map<String, dynamic>>(url, data: {"deviceKey": deviceKey, "registrationToken": registrationToken});
    return (deviceKey: deviceKey);
  }
}
