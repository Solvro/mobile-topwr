import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../presentation/department_detail_view.dart";
import "../models/detailed_department.dart";

part "department_details_repository.g.dart";

@riverpod
Future<DetailedDepartment> departmentDetailsRepository2(Ref ref, int id) async {
  final url = "${Env.mainRestApiUrl}/departments/$id?fieldOfStudy=true&departmentLink=true";

  final response = await ref.getAndCacheData(
    url,
    TtlStrategy.get(TtlKey.departmentDetailsRepository).inDays,
    DetailedDepartment.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: DepartmentDetailView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  return response;
}
