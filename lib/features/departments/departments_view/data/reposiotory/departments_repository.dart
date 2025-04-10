import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../departments_view.dart";
import "../models/department.dart";

part "departments_repository.g.dart";

@riverpod
Future<IList<Department>> departmentsRepository(Ref ref) async {
  final url = "${Env.mainRestApiUrl}/departments";

  final response = await ref.getAndCacheData(
    url,
    TtlStrategy.get(TtlKey.departmentsRepository).inDays,
    Department.fromJsonList,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: DepartmentsView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  return response;
}
