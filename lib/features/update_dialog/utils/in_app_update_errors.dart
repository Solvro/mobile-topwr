import "package:flutter/services.dart";

/// Play Core / in_app_update failures that reflect device or Play state, not app bugs.
bool isIgnorableInAppUpdateError(PlatformException exception) {
  if (exception.code != "TASK_FAILURE") {
    return false;
  }

  final message = exception.message ?? "";
  if (message.contains("Failed to bind to the service")) {
    return true;
  }

  return RegExp(r"Install Error\(-\d+\)").hasMatch(message);
}
