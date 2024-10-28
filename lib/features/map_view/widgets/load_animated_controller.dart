import "package:flutter/material.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";

import "../controllers/controllers_set.dart";
import "../controllers/map_controller.dart";

// instead of using a StatefulWidget, we could have created a custom Hook, similar to `useAnimationController`
// but it would be even less readable to define it (but then re-using it would be nice)
class LoadAnimationMapController<T extends GoogleNavigable>
    extends StatefulWidget {
  const LoadAnimationMapController({
    super.key,
    required this.builder,
    required this.myMapController,
  });
  final Widget Function(BuildContext context, AnimatedMapController controller)
      builder;
  final MyMapController<T> myMapController;

  @override
  State<LoadAnimationMapController> createState() =>
      _LoadAnimationMapControllerState<T>();
}

class _LoadAnimationMapControllerState<T extends GoogleNavigable>
    extends State<LoadAnimationMapController<T>> with TickerProviderStateMixin {
  late final controller = AnimatedMapController(vsync: this);

  @override
  void initState() {
    super.initState();
    widget.myMapController.completeController(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
