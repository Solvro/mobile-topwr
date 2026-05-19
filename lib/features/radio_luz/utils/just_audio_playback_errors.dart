import "package:flutter/services.dart";
import "package:just_audio/just_audio.dart";
import "package:logger/logger.dart";

/// ExoPlayer `[TYPE_SOURCE]` failures (unreachable stream, network, etc.) on Android.
bool isIgnorableJustAudioPlaybackError(Object error) {
  if (error is PlayerException) {
    return error.code == 0;
  }
  if (error is PlatformException) {
    return error.code == "0" && error.message == "Source error";
  }
  return false;
}

String describeJustAudioPlaybackError(Object error) {
  if (error is PlayerException) {
    return "PlayerException(code: ${error.code}, message: ${error.message}, details: ${error.details})";
  }
  if (error is PlatformException) {
    return "PlatformException(code: ${error.code}, message: ${error.message}, details: ${error.details})";
  }
  return error.toString();
}

void logJustAudioPlaybackError(String context, Object error, [StackTrace? stackTrace]) {
  final message = "[$context] ${describeJustAudioPlaybackError(error)}";
  if (isIgnorableJustAudioPlaybackError(error)) {
    Logger().w(message, error: error, stackTrace: stackTrace);
  } else {
    Logger().e(message, error: error, stackTrace: stackTrace);
  }
}

void logAndRethrowJustAudioPlaybackError(String context, Object error, StackTrace stackTrace) {
  logJustAudioPlaybackError(context, error, stackTrace);
  if (isIgnorableJustAudioPlaybackError(error)) return;

  Error.throwWithStackTrace(error, stackTrace);
}
