import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "departments_extensions.dart";
import "getDepartments.graphql.dart";

part "departments_repository.g.dart";

typedef Department = Query$GetDepartments$Departments;

@riverpod
Future<List<Department>> departmentsRepository(
  DepartmentsRepositoryRef ref,
) async {
  final results = await ref.queryGraphql(
    Options$Query$GetDepartments(),
    TtlKey.departmentsRepository,
  );
  return (results?.Departments?..sortByCodeOrder()) ?? [];
}
