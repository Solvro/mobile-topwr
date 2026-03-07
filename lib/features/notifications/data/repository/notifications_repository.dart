import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../models/notification_model.dart";

part "notifications_repository.g.dart";

@riverpod
Future<IList<NotificationModel>> notificationsRepository(Ref ref) async {
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
  return allNotifications.where((notification) => notification.wasSent).toIList();
}
