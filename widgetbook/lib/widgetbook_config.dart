import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/theme/app_theme.dart";
import "package:widgetbook/widgetbook.dart";

import "components.g.dart";

final config = Config(
  components: components,
  addons: [AlignmentAddon()],
  appBuilder: (context, child) {
    return ProviderScope(
      child: Theme(data: const AppTheme().light, child: child),
    );
  },
);
