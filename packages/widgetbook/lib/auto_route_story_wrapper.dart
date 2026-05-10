import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";

class WidgetbookAutoRouteScope extends StatelessWidget {
  const WidgetbookAutoRouteScope({required this.child, super.key});

  final Widget child;

  static final _router = RootStackRouter.build(routes: []);

  @override
  Widget build(BuildContext context) {
    return RouteDataScope(routeData: _router.routeData, child: child);
  }
}
