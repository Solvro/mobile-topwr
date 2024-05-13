import 'package:flutter/material.dart';

import '../controllers/controllers_set.dart';

class MapConfig<T> extends InheritedWidget {
  const MapConfig({
    super.key,
    required this.controllers,
    required super.child,
  });

  final MapControllers<T> controllers;

  @override
  bool updateShouldNotify(covariant MapConfig<dynamic> oldWidget) {
    return controllers != oldWidget.controllers;
  }
}
