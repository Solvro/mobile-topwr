import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/navigator/app_router.dart";
import "package:topwr/features/navigator/navigation_stack.dart";
import "package:topwr/widgets/detail_views/pop_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DetailViewPopButton)
Widget useCaseDetailViewPopButton(BuildContext context) {
  const mockCurrentRouteName = "WidgetbookDetailMockRoute";
  const mockCurrentRouteSettings = RouteSettings(name: mockCurrentRouteName);

  final mockPreviousRoute = MaterialPageRoute<void>(
    settings: const RouteSettings(name: DepartmentsRoute.name),
    builder: (_) => const SizedBox.shrink(),
  );

  return ProviderScope(
    overrides: [
      previousRouteThanProvider(mockCurrentRouteSettings).overrideWithValue(mockPreviousRoute),
    ],
    child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        settings: mockCurrentRouteSettings,
        builder: (_) => const Center(child: DetailViewPopButton()),
      ),
    ),
  );
}

@widgetbook.UseCase(name: "icon only", type: DetailViewPopButton)
Widget useCaseDetailViewPopButtonIconOnly(BuildContext context) {
  return const Center(child: DetailViewPopButton());
}
