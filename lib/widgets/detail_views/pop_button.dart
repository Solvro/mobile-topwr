import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../features/navigator/app_router.dart";
import "../../features/navigator/navigation_stack.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";

class DetailViewPopButton extends ConsumerWidget {
  const DetailViewPopButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ModalRoute.of(context);
    final stack = ref.watch(navigationStackProvider);
    final routeIndex = stack.lastIndexWhere((stackRoute) => identical(stackRoute, route));
    final previousRoute = routeIndex > 0 ? stack[routeIndex - 1] : null;
    final title = _getPreviousRouteTitle(previousRoute, context);

    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2)),

      child: Semantics(
        label: title != null
            ? "${context.localize.get_back_screen_reader_label} $title"
            : context.localize.get_back_screen_reader_with_title_label,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(Icons.chevron_left, size: 18, color: context.colorScheme.primary),
            ),
            if (title != null)
              Flexible(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? _getPreviousRouteTitle(Route<dynamic>? route, BuildContext context) {
    final args = route?.settings.arguments;
    if (route?.settings.name == RootRoute.name && args is RootRouteArgs && !args.isFirstRootBottomView) {
      return args.initialTabToGetBackTo.getRootRouteTitle(context);
    }

    return route?.getFormattedRouteName(context);
  }
}
