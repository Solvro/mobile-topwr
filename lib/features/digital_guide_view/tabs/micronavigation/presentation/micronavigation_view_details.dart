import "package:audioplayers/audioplayers.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/my_html_widget.dart";

@RoutePage()
class MicronavigationViewDetails extends StatefulWidget {
  const MicronavigationViewDetails({
    super.key,
    required this.title,
    required this.comment,
    required this.soundURL,
  });

  final String title;
  final String comment;
  final String soundURL;

  @override
  State<MicronavigationViewDetails> createState() =>
      _MicronavigationViewDetailsState();
}

class _MicronavigationViewDetailsState
    extends State<MicronavigationViewDetails> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> _playOrPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.play(UrlSource(widget.soundURL));
      setState(() {
        _isPlaying = true;
      });

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _isPlaying = false;
        });
      });
    }
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = [
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(
        widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: context.colorTheme.blackMirage,
        ),
      ),
      Divider(
        color: context.colorTheme.orangePomegranade,
        thickness: 3,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(
        context.localize.communique,
        style: context.textTheme.title,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      MyHtmlWidget(widget.comment),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(
        context.localize.audio_message,
        style: context.textTheme.title,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      IconButton(
        onPressed: _playOrPauseAudio,
        icon: Icon(
          _isPlaying ? Icons.pause_circle : Icons.play_circle,
          size: 36,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: context.colorTheme.greyLight,
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.paddingMedium,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
