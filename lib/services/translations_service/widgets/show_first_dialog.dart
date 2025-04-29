import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../hooks/use_language_dialog.dart";

class ShowFirstTranslationDialog extends HookConsumerWidget {
  const ShowFirstTranslationDialog({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLanguageDialogIfNotSet(context, ref);
    return child;
  }
}
