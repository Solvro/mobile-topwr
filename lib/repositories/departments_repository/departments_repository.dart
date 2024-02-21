import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/gql_client_provider.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getDepartments.graphql.dart';

part 'departments_repository.g.dart';

typedef Department = Query$GetDepartments$departments; // just alias for shorter type name

@riverpod
Stream<List<Department?>?> departmentsRepository(DepartmentsRepositoryRef ref) async* {
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
    client,
    WatchOptions$Query$GetDepartments(
        eagerlyFetchResults: true, 
    ),
  );
  yield* stream.map(
    (event) => event?.departments,
  );
}