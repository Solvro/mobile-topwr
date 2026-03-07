import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../departments/departments_view/widgets/departments_view_loading.dart";
import "../data/models/notification_model.dart";
import "../data/repository/notifications_repository.dart";
import "notification_details_dialog.dart";

@RoutePage()
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(title: (text: context.localize.notifications, context: context), leadingWidth: 96),
      body: const _NotificationsList(),
    );
  }
}

class _NotificationsList extends ConsumerWidget {
  const _NotificationsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsRepositoryProvider);

    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncData(:final value) => _NotificationsListContent(value),
      _ => const Padding(padding: GuideViewConfig.gridPadding, child: DepartmentsViewLoading()),
    };
  }
}

class _NotificationsListContent extends ConsumerWidget {
  const _NotificationsListContent(this.notifications);

  final IList<NotificationModel> notifications;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (notifications.isEmpty) {
      return Center(child: Text(context.localize.no_notifications));
    }
    return ListView.separated(
      key: MyAppConfig.verticalScrollableKey,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      itemCount: notifications.length,
      separatorBuilder: (_, _) => const SizedBox(height: DepartmentsConfig.listSeparatorSize),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return WideTileCard(
          title: notification.title,
          subtitle: notification.body,
          onTap: notification.data?.route != null ? () => ref.launch(notification.data!.route!) : null,
          trailing: IconButton(
            tooltip: context.localize.more_info,
            onPressed: () => NotificationDetailsDialog.show(context, ref, notification),
            icon: Icon(Icons.info, size: context.textScaler.scale(22), color: context.colorScheme.tertiary),
          ),
        );
      },
    );
  }
}
