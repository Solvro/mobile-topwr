import "package:auto_route/auto_route.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../app_router.dart";
import "../navigation_stack.dart";

@RoutePage()
class ApplicationView extends ConsumerWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(currentRouteProvider)?.settings.name;
    final isRadioLuz = currentRoute == RadioLuzRoute.name;

    return Stack(
      children: [
        const AutoRouter(),
        if (!isRadioLuz) const Positioned(right: 50, bottom: 100, child: Text("Hello")),
      ],
    );
  }
}
