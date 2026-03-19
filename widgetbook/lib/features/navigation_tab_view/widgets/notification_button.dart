import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/widgets/notification_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NotificationButton)
Widget useCaseNotificationButton(BuildContext context) {
  return const NotificationButton();
}
