import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../service/radio_player_controller.dart";

class RadioPlayerControlButton extends StatelessWidget {
  const RadioPlayerControlButton({
    super.key,
    required this.radioController,
    required this.isPlaying,
    required this.isLoading,
  });

  final RadioController radioController;
  final bool isPlaying;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var buttonText = isPlaying ? context.localize.stop_playing : context.localize.start_playing;
    if (isLoading) buttonText = context.localize.loading;

    return ElevatedButton(
      onPressed: () async {
        if (isPlaying) {
          await radioController.pause();
        } else {
          await radioController.play();
        }
      },
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(100, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(RadioLuzConfig.paddingSmall),
        elevation: 2,
      ),
      child: Row(
        spacing: RadioLuzConfig.spacingSmall,
        children: [
          if (isLoading)
            SizedBox.square(
              dimension: 12,
              child: CircularProgressIndicator(color: context.colorScheme.primary, strokeWidth: 2),
            )
          else
            Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 16, color: context.colorScheme.primary),
          Expanded(
            child: Center(
              child: Text(
                buttonText,
                style: context.textTheme.titleLarge
                    ?.copyWith(color: context.colorScheme.primary)
                    .copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
