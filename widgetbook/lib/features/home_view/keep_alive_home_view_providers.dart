import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/keep_alive_home_view_providers.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: KeepAliveHomeViewProviders)
Widget useCaseKeepAliveHomeViewProviders(BuildContext context) {
  return const KeepAliveHomeViewProviders(child: SizedBox(width: 100, height: 100));
}
