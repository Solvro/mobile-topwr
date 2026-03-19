import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/widgets/logo_app_bar.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AppBarLogo)
Widget useCaseAppBarLogo(BuildContext context) {
  return const AppBarLogo();
}
