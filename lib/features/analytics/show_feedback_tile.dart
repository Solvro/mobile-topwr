import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:wiredash/wiredash.dart";

import "../../config/ui_config.dart";
import "../../config/wiredash.dart";
import "../../gen/assets.gen.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/wide_tile_card.dart";

class ShowFeedbackTile extends StatelessWidget {
  const ShowFeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      title: context.localize.bug_report_title,
      subtitle: context.localize.bug_report_subtitle,
      onTap: () async {
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
    );
  }
}
