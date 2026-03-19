import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../models/notification_model.dart";

part "notifications_repository.g.dart";

@riverpod
class NotificationsRepository extends _$NotificationsRepository {
  Future<void> clearCache() async {
    await ref.clearCache("${Env.mainRestApiUrl}/notification", TtlDays.notifications);
  }

  @override
  Future<IList<NotificationModel>> build() async {
    final url = "${Env.mainRestApiUrl}/notification";
    final allNotifications = await ref
        .getAndCacheData(
          url,
          NotificationModel.fromJson,
          ttlDays: TtlDays.notifications,
          extraValidityCheck: (_) => true,
          onRetry: ref.invalidateSelf,
        )
        .castAsList;

    final sortedNotifications = allNotifications
        .where((notification) => notification.wasSent)
        .sortedByCompare((notification) => notification.createdAt, (a, b) => b.compareTo(a));
    return sortedNotifications.toIList();
  }
}
