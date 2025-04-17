import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../presentation/department_detail_view.dart";
import "../models/department_details.dart";

part "department_details_repository.g.dart";

@riverpod
Future<DepartmentDetails> departmentDetailsRepository(Ref ref, int id) async {
  final endpoint = "/departments/$id?fieldOfStudy=true&departmentLink=true";
  final url = "${Env.mainRestApiUrl}$endpoint";

  final response = await ref.getAndCacheData(
    url,
    TtlStrategy.get(TtlKey.departmentDetailsRepository).inDays,
    DepartmentDetailsResponse.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: DepartmentDetailView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  return response.data;
}
