import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../hooks/use_effect_on_init.dart";
import "show_changelog.dart";

class UpdateChangelogWrapper extends HookConsumerWidget {
  const UpdateChangelogWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(() {
      unawaited(showChangelog(context, ref));
      return null;
    });

    return child;
  }
}
