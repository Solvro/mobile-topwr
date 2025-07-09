import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "accessibility_mode_repository.dart";
import "modes.dart";

part "active_accessibility_modes_repository.g.dart";

const modes = <ModeWithKey>[
  MotorImpairment(),
  Blind(),
  LowVision(),
  SensorySensitivity(),
  CognitiveImpairment(),
  HearingImpairment(),
];

@riverpod
Future<ISet<ModeWithKey>> activeAccessibilityModesRepository(Ref ref) async {
  final modeStatesTuples = modes.map((mode) => (mode, ref.watch(accessibilityModeRepositoryProvider(mode))));

  final activeModes = modeStatesTuples
      .where((tuple) => tuple.$2.asData?.value ?? false)
      .map((tuple) => tuple.$1)
      .toISet();

  return activeModes;
}
