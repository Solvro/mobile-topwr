/*
  This class is used to observe the navigation stack
  Acts as a bridge between navigator and riverpod state notifier
*/
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/umami.dart";

class UmamiNavigationObserver extends NavigatorObserver {
  final WidgetRef ref;

  UmamiNavigationObserver(this.ref);

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    super.didChangeTop(topRoute, previousTopRoute);
    final name = topRoute.settings.name;
    if (name is String) {
      unawaited(ref.trackScreen(name));
    }
  }
}
