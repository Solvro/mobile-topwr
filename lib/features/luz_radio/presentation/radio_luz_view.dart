import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "audio_player_widget.dart";

@RoutePage()
class RadioLuzView extends StatelessWidget {
  const RadioLuzView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AudioPlayerWidget()));
  }
}
