import "package:flutter/widgets.dart";
import "package:topwr/features/notifications/presentation/notifications_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NotificationsView)
Widget useCaseNotificationsView(BuildContext context) {
  return const NotificationsView();
}
