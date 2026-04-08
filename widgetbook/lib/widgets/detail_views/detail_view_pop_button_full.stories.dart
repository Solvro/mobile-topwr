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
    const mockCurrentRouteName = "WidgetbookDetailMockRoute";
    const mockCurrentRouteSettings = RouteSettings(name: mockCurrentRouteName);

    final mockPreviousRoute = MaterialPageRoute<void>(
      settings: const RouteSettings(name: DepartmentsRoute.name),
      builder: (_) => const SizedBox.shrink(),
    );

    return ProviderScope(
      overrides: [previousRouteThanProvider(mockCurrentRouteSettings).overrideWithValue(mockPreviousRoute)],
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute<void>(
          settings: mockCurrentRouteSettings,
          builder: (_) => const Center(child: DetailViewPopButton()),
        ),
      ),
    );
  }
}

const meta = Meta<DetailViewPopButtonFullStory>();

final $default = DetailViewPopButtonFullStoryStory();
