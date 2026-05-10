import "dart:async";

import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:logger/logger.dart";

import "config/env.dart";
import "firebase_options.dart";

Future<void> firebaseInit() async {
  try {
    // * General Firebase setup
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    if (kDebugMode) {
      unawaited(FirebaseMessaging.instance.getToken(vapidKey: kIsWeb ? Env.vapidWebPubKey : null).then(Logger().i));
    }
  } on Exception {
    if (kDebugMode) {
      Logger().w("Firebase initialization skipped or failed (may be in test environment)");
    }
  }
}

Future<void> requestFCMPermission() async {
  if (kIsWeb) {
    return;
  }
  try {
    await FirebaseMessaging.instance.requestPermission();
  } on Exception {
    if (kDebugMode) {
      Logger().w("FCM permission request skipped (may be in test environment)");
    }
  }
}

void subscribeToAllUsersTopic() {
  try {
    unawaited(FirebaseMessaging.instance.subscribeToTopic("all-users"));
  } on Exception {
    Logger().e("Failed to subscribe to all-users topic");
    return;
  }
}
