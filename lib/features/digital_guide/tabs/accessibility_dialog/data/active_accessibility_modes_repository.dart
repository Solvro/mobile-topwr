import "dart:async";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
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

@Riverpod(keepAlive: true)
class ActiveAccessibilityModesRepository extends _$ActiveAccessibilityModesRepository {
  @override
  Future<ISet<ModeWithKey>> build() async {
    final previous = state.asData?.value;

    if (previous != null) {
      state = AsyncValue.data(previous);
    }

    final modeStates = await Future.wait(
      modes.map((mode) => ref.watch(accessibilityModeRepositoryProvider(mode).future)),
    );

    final activeModes = <ModeWithKey>[
      for (var i = 0; i < modes.length; i++)
        if (modeStates[i]) modes[i],
    ].toISet();

    return activeModes;
  }
}
