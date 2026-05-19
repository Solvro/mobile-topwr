import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:topwr/features/update_dialog/utils/in_app_update_errors.dart";

void main() {
  group("isIgnorableInAppUpdateError", () {
    test("ignores Play Store not found (-9)", () {
      expect(
        isIgnorableInAppUpdateError(
          PlatformException(
            code: "TASK_FAILURE",
            message:
                "-9: Install Error(-9): The Play Store app is either not installed or not the official version.",
          ),
        ),
        isTrue,
      );
    });

    test("ignores install not allowed (-6)", () {
      expect(
        isIgnorableInAppUpdateError(
          PlatformException(
            code: "TASK_FAILURE",
            message:
                "-6: Install Error(-6): The download/install is not allowed, due to the current device state.",
          ),
        ),
        isTrue,
      );
    });

    test("ignores app not owned (-10)", () {
      expect(
        isIgnorableInAppUpdateError(
          PlatformException(
            code: "TASK_FAILURE",
            message:
                "-10: Install Error(-10): The app is not owned by any user on this device.",
          ),
        ),
        isTrue,
      );
    });

    test("ignores Play Core service bind failures", () {
      expect(
        isIgnorableInAppUpdateError(
          PlatformException(
            code: "TASK_FAILURE",
            message: "Failed to bind to the service.",
          ),
        ),
        isTrue,
      );
    });

    test("does not ignore unrelated platform exceptions", () {
      expect(
        isIgnorableInAppUpdateError(
          PlatformException(code: "OTHER", message: "Install Error(-9): ..."),
        ),
        isFalse,
      );
      expect(
        isIgnorableInAppUpdateError(
          PlatformException(code: "TASK_FAILURE", message: "Unexpected failure"),
        ),
        isFalse,
      );
    });
  });
}
