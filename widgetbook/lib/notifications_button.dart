import "package:flutter/material.dart";
import "package:topwr/features/navigation_tab_view/widgets/notification_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "Default", type: NotificationButton)
Widget buildNotificationButtonUseCase(BuildContext context) {
  return const NotificationButton();
}
