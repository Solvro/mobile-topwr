// https://dart.dev/language/class-modifiers#sealed
sealed class AccessibilityMode {
  const AccessibilityMode();
}

// this mode's state depends on the state of its children
sealed class ModeWithChildren extends AccessibilityMode {
  const ModeWithChildren(this.children);
  final List<AccessibilityMode> children;
}

// this mode's state is stored locally in shared preferences
sealed class ModeWithKey extends AccessibilityMode {
  const ModeWithKey(this.sharedPrefsKey);
  final String sharedPrefsKey;
}

class MotorImpairment extends ModeWithKey {
  const MotorImpairment() : super("_prefs_accessibility_motor_impairment");
}

class Blind extends ModeWithKey {
  const Blind() : super("_prefs_accessibility_blind");
}

class LowVision extends ModeWithKey {
  const LowVision() : super("_prefs_accessibility_low_vision");
}

class SensorySensitivity extends ModeWithKey {
  const SensorySensitivity()
      : super("_prefs_accessibility_sensory_sensitivity");
}

class CognitiveImpairment extends ModeWithKey {
  const CognitiveImpairment()
      : super("_prefs_accessibility_cognitive_impairment");
}

class HearingImpairment extends ModeWithKey {
  const HearingImpairment() : super("_prefs_accessibility_hearing_impairment");
}

class VisualImpairment extends ModeWithChildren {
  const VisualImpairment()
      : super(
          const [
            LowVision(),
            Blind(),
          ],
        );
}
