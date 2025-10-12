import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "audio_player_widget.dart";

@RoutePage()
class RadioLuzView extends StatelessWidget {
  const RadioLuzView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Center(child: AudioPlayerWidget()),
    );
  }
}
