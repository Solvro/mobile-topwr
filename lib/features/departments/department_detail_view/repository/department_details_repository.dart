import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/query_adapter.dart";
import "../../../../api_base/translations/temp_graphql_translate.dart";
import "../../../../config/ttl_config.dart";
import "getDepartmentDetails.graphql.dart";

part "department_details_repository.g.dart";

typedef DepartmentDetails = Query$GetDepartmentDetails;
typedef DepartmentDetailsDetails = Query$GetDepartmentDetails$Departments_by_id;
typedef _Vars = Variables$Query$GetDepartmentDetails;

@riverpod
Future<DepartmentDetails?> departmentDetailsRepository(Ref ref, String id) async {
  final detail = await ref.queryGraphql(
    Options$Query$GetDepartmentDetails(variables: _Vars(id: id)),
    TtlKey.departmentDetailsRepository,
  );
  return detail?.copyWith(
    Departments_by_id: detail.Departments_by_id?.copyWith(
      name: await ref.translateGraphQLMaybeString(detail.Departments_by_id?.name),
      links: await ref.translateGraphQLModelList(
        detail.Departments_by_id?.links ?? [],
        (link) async => link?.copyWith(
          name: await ref.translateGraphQLMaybeString(link.name),
          link: await ref.translateGraphQLMaybeString(link.link),
        ),
      ),
    ),
  );
}
