import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getDepartmentDetails.graphql.dart";

part "department_details_repository.g.dart";

typedef DepartmentDetails = Query$GetDepartmentDetails;
typedef DepartmentDetailsDetails = Query$GetDepartmentDetails$Departments_by_id;
typedef _Vars = Variables$Query$GetDepartmentDetails;

@riverpod
Future<DepartmentDetails?> departmentDetailsRepository(
  Ref ref,
  String id,
) async {
  return ref.queryGraphql(
    Options$Query$GetDepartmentDetails(
      variables: _Vars(id: id),
    ),
    TtlKey.departmentDetailsRepository,
  );
}
