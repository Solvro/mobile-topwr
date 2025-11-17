import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/navigator/providers/is_bottom_sheet_open.dart";

Future<void> showCustomModalBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required Widget child,
}) async {
  ref.read(isBottomSheetOpenProvider.notifier).setState(newState: true);

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(),
    builder: (BuildContext context) => Semantics(explicitChildNodes: true, container: true, child: child),
  );

  ref.read(isBottomSheetOpenProvider.notifier).setState(newState: false);
}
