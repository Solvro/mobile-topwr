import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/remote_config/data/models/remote_config.dart";
import "package:topwr/features/remote_config/data/repository/remote_config_repository.dart";
import "package:topwr/features/remote_config/presentation/kill_switch_overlay.dart";
import "package:widgetbook/widgetbook.dart";

part "kill_switch_overlay.stories.g.dart";

const _config = RemoteConfig(
  cmsReferenceNumber: 0,
  daySwapLookahead: 7,
  translatorReferenceNumber: 0,
  killswitchOfDoomAndDespair: true,
);

class KillSwitchOverlayStoryKnobs {
  const KillSwitchOverlayStoryKnobs({required this.child});

  final Widget child;
}

const meta = Meta(KillSwitchOverlay.new, argsType: KillSwitchOverlayStoryKnobs.new);

final defaults = _Defaults(builder: (context, args) => KillSwitchOverlay(child: args.child));

final $default = KillSwitchOverlayStory(
  name: "Maintenance warning",
  args: KillSwitchOverlayStoryKnobsArgs(child: Arg.fixed(const ColoredBox(color: Color(0xFFFFFFFF)))),
  setup: (context, child, args) =>
      ProviderScope(overrides: [remoteConfigRepositoryProvider.overrideWith((ref) => _config)], child: child),
);
