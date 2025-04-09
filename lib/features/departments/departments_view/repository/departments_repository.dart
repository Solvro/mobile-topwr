import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "../../../../utils/ilist_nonempty.dart";
import "getDepartments.graphql.dart";

part "departments_repository.g.dart";

typedef Department = Query$GetDepartments$Departments;

@riverpod
Future<IList<Department>> departmentsRepository(Ref ref) async {
  final results = await ref.queryGraphql(Options$Query$GetDepartments(), TtlKey.departmentsRepository);
  return (results?.Departments).toIList();
}
