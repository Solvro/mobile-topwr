import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../models/department.dart";

part "departments_repository.g.dart";

@riverpod
Future<IList<Department>?> departmentsRepository2(Ref ref) async {
  final url = "${Env.mainRestApiUrl}/";

  // ref.getAndCacheData(

  // )

  return null;
}
