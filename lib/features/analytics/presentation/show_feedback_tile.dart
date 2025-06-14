import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:lottie/lottie.dart";
import "package:wiredash/wiredash.dart";

import "../../../config/ui_config.dart";
import "../../../config/wiredash.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/wide_tile_card.dart";
import "../data/umami.dart";
import "../data/umami_events.dart";

class ShowFeedbackTile extends ConsumerWidget {
  const ShowFeedbackTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label:
          "${context.localize.bug_report_title}. ${context.localize.feedback_option_not_supported_for_screen_readers}",
      child: ExcludeSemantics(
        child: WideTileCard(
          title: context.localize.bug_report_title,
          subtitle: context.localize.bug_report_subtitle,
          onTap: () async {
            unawaited(ref.trackEvent(UmamiEvents.openFeedbackForm));
            await Wiredash.of(context).show(options: WiredashFeedbackOptions(labels: context.labels));
          },
          trailing: Lottie.asset(
            Assets.animations.bug,
            width: WideTileCardConfig.imageSize,
            height: WideTileCardConfig.imageSize,
            animate: true,
            repeat: true,
            renderCache: RenderCache.drawingCommands,
          ),
        ),
      ),
    );
  }
}
