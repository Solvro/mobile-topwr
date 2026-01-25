import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../service/radio_player_controller.dart";
import "audio_player_widget.dart";
import "broadcasts_section.dart";
import "now_playing_section.dart";
import "radio_luz_app_bar.dart";
import "radio_luz_socials_section.dart";
import "radio_luz_title.dart";

@RoutePage()
class RadioLuzView extends HookConsumerWidget {
  const RadioLuzView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    final cappedTextScale = context.textScaler.clamp(maxScaleFactor: 1.7);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(ref.read(radioControllerProvider.notifier).preload());
      });
      return null;
    }, []);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: cappedTextScale),
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceTint,
        appBar: RadioLuzAppBar(context, logoSize: 55),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: RadioLuzConfig.horizontalBasePadding),
              children: [
                RadioLuzTitle(title: l10n.now_playing.toUpperCase()),
                const SizedBox(height: 12),
                const NowPlayingSection(),
                const SizedBox(height: 24),
                RadioLuzTitle(title: l10n.broadcast.toUpperCase()),
                const SizedBox(height: 12),
                const BroadcastsSection(),
                const SizedBox(height: 20),
                RadioLuzTitle(title: l10n.radio_luz_info.toUpperCase()),
                const SizedBox(height: 12),
                const _TextSection(),
                const SizedBox(height: 12),
                const RadioLuzSocialsSection(),
                const SizedBox(height: 80),
              ],
            ),
            const Align(alignment: Alignment.bottomCenter, child: AudioPlayerWidget()),
          ],
        ),
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.localize;

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: RadioLuzConfig.horizontalBasePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          Text(l10n.radio_luz_description1, style: context.textTheme.bodyLarge),
          Text(l10n.radio_luz_description2, style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
