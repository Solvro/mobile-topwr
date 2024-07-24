import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base/ttl/ttl_service.dart";
import "../../../config/ttl_config.dart";
import "../messages_config.dart";
import "general_offline_message.dart";

class OfflineGraphQLMessage extends ConsumerWidget {
  const OfflineGraphQLMessage(this.exceptionSourceKey, {super.key});
  final TtlKey exceptionSourceKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OfflineMessage(
      context.gqlOfflineMessageLocalized(exceptionSourceKey),
      onRefresh: () => ref.refresh(ttlServiceProvider.call(exceptionSourceKey)),
    );
  }
}
