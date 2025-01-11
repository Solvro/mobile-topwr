import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/my_html_widget.dart";
import "widgets/my_audio_player.dart";

@RoutePage()
class MicronavigationDetailView extends StatefulWidget {
  const MicronavigationDetailView({
    super.key,
    required this.title,
    required this.comment,
    required this.soundURL,
  });

  final String title;
  final String comment;
  final String soundURL;

  @override
  State<MicronavigationDetailView> createState() =>
      _MicronavigationDetailViewState();
}

class _MicronavigationDetailViewState extends State<MicronavigationDetailView> {
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
      const SizedBox(height: DigitalGuideConfig.heightBig),
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
      Text(
        context.localize.audio_message_comment,
        style: context.textTheme.body,
      ),
      Padding(
        padding: DigitalGuideConfig.symetricalPaddingBig,
        child: MyAudioPlayer(audioUrl: widget.soundURL),
      ),
    ];

    return Scaffold(
      backgroundColor: context.colorTheme.greyLight,
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.paddingBig,
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
