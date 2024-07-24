import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_text_button.dart";

class OfflineMessage extends StatelessWidget {
  const OfflineMessage(this.errMessage, {super.key, this.onRefresh});
  final String errMessage;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Text(
            errMessage,
            style: context.textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.wifi_off_outlined,
            size: 30,
            color: context.colorTheme.greyPigeon,
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? _) =>
              MyTextButton(
            actionTitle: context.localize.refresh,
            onClick: onRefresh,
          ),
        ),
      ],
    );
  }
}
