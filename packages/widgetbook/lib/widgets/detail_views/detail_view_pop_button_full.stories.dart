import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/navigator/app_router.dart";
import "package:topwr/features/navigator/navigation_stack.dart";
import "package:topwr/widgets/detail_views/pop_button.dart";
import "package:widgetbook/widgetbook.dart";

part "detail_view_pop_button_full.stories.g.dart";

class DetailViewPopButtonFullStory extends StatelessWidget {
  const DetailViewPopButtonFullStory({super.key});

  @override
  Widget build(BuildContext context) {
    const mockCurrentRouteSettings = RouteSettings(name: "WidgetbookDetailMockRoute");

    final mockPreviousRoute = MaterialPageRoute<void>(
      settings: const RouteSettings(name: DepartmentsRoute.name),
      builder: (_) => const SizedBox.shrink(),
    );

    // [DetailViewPopButton] watches [previousRouteThanProvider(ModalRoute.of(context)!.settings)].
    // Override using the same [RouteSettings] instance the route exposes (not a preset family key).
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        settings: mockCurrentRouteSettings,
        builder: (_) => Builder(
          builder: (context) {
            final routeSettings = ModalRoute.of(context)!.settings;
            return ProviderScope(
              overrides: [previousRouteThanProvider(routeSettings).overrideWithValue(mockPreviousRoute)],
              child: const Center(child: DetailViewPopButton()),
            );
          },
        ),
      ),
    );
  }
}

const meta = Meta<DetailViewPopButtonFullStory>();

final $default = DetailViewPopButtonFullStoryStory();
