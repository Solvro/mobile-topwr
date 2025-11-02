import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "audio_player_widget.dart";
import "broadcasts_section.dart";
import "now_playing_section.dart";
import "radio_luz_app_bar.dart";
import "radio_luz_socials_section.dart";
import "radio_luz_title.dart";

@RoutePage()
class RadioLuzView extends StatelessWidget {
  const RadioLuzView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localize;
    return Scaffold(
      backgroundColor: context.colorTheme.greyLight,
      appBar: RadioLuzAppBar(context, logoSize: 55),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
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
              Text(l10n.radio_luz_description1, style: context.textTheme.body),
              const SizedBox(height: 2),
              Text(l10n.radio_luz_description2, style: context.textTheme.body),
              const SizedBox(height: 12),
              const RadioLuzSocialsSection(),
              const SizedBox(height: 80),
            ],
          ),
          const Align(alignment: Alignment.bottomCenter, child: AudioPlayerWidget()),
        ],
      ),
    );
  }
}
