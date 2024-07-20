import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../api_base/watch_query_adapter.dart';
import '../../../config/ttl_config.dart';
import 'getDepartmentDetails.graphql.dart';

part 'department_details_repository.g.dart';

typedef DepartmentDetails = Query$GetDepartmentDetails;
typedef StudyCircles = Query$GetDepartmentDetails$Scientific_Circles;
typedef _Vars = Variables$Query$GetDepartmentDetails;
@riverpod
Stream<DepartmentDetails?> departmentDetailsRepository(
    DepartmentDetailsRepositoryRef ref, String id) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetDepartmentDetails(eagerlyFetchResults: true, variables: _Vars(id: id)),
    TtlKey.departmentsDetailsRepository,
  );
  yield* stream.map((event) => event);
  }

