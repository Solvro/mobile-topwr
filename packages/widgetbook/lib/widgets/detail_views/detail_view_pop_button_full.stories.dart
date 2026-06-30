import "package:fast_immutable_collections/fast_immutable_collections.dart";
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

    final Route<dynamic> mockPreviousRoute = MaterialPageRoute<void>(
      settings: const RouteSettings(name: DepartmentsRoute.name),
      builder: (_) => const SizedBox.shrink(),
    );

    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        settings: mockCurrentRouteSettings,
        builder: (context) {
          final mockCurrentRoute = ModalRoute.of(context)!;
          return ProviderScope(
            overrides: [
              navigationStackProvider.overrideWithValue([mockPreviousRoute, mockCurrentRoute].lock),
            ],
            child: const Center(child: DetailViewPopButton()),
          );
        },
      ),
    );
  }
}

const meta = Meta(DetailViewPopButtonFullStory.new);

final $default = DetailViewPopButtonFullStoryStory();
