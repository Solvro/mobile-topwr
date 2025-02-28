import "dart:async";

import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:logger/logger.dart";

import "firebase_options.dart";

Future<void> firebaseInit() async {
  // * General Firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // * Crashlytics setup
  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
      return true;
    };
  }

  if (kDebugMode) {
    unawaited(FirebaseMessaging.instance.getToken().then(Logger().i));
  }
}

Future<void> requestFCMPermission() async {
  await FirebaseMessaging.instance.requestPermission();
}
