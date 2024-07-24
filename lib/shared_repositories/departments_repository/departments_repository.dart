import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/watch_query_adapter.dart";
import "../../config/ttl_config.dart";
import "departments_extra_params_ext.dart";
import "getDepartments.graphql.dart";

part "departments_repository.g.dart";

typedef Department = Query$GetDepartments$Departments;

@riverpod
Stream<List<Department?>?> departmentsRepository(
    DepartmentsRepositoryRef ref,) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetDepartments(
      eagerlyFetchResults: true,
    ),
    TtlKey.departmentsRepository,
  );
  yield* stream.map(
    (event) => event?.Departments?..sortByCodeOrder(),
  );
}
