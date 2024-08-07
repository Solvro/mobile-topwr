import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/watch_query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getDepartmentDetails.graphql.dart";

part "department_details_repository.g.dart";

typedef DepartmentDetails = Query$GetDepartmentDetails;
typedef ScienceClubs = Query$GetDepartmentDetails$Scientific_Circles;
typedef DepartmentDetailsDetails = Query$GetDepartmentDetails$Departments_by_id;
typedef _Vars = Variables$Query$GetDepartmentDetails;

@riverpod
Stream<DepartmentDetails?> departmentDetailsRepository(
  DepartmentDetailsRepositoryRef ref,
  String id,
) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetDepartmentDetails(
      eagerlyFetchResults: true,
      variables: _Vars(
        id: id,
        fid: id,
      ),
    ),
    TtlKey.departmentDetailsRepository,
  );
  yield* stream.map((event) => event);
}
