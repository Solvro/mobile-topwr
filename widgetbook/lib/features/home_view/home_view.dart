import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/home_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HomeView)
Widget useCaseHomeView(BuildContext context) {
  return const HomeView();
}
