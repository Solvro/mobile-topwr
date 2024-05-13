import 'package:flutter/material.dart';

import '../controllers/controllers_set.dart';

class MapControllers<T> extends InheritedWidget {
  const MapControllers({
    super.key,
    required this.data,
    required super.child,
  });

  final MapControllersT<T> data;

  @override
  bool updateShouldNotify(covariant MapControllers<dynamic> oldWidget) {
    return data != oldWidget.data;
  }
}
