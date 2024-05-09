import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/ttl/ttl_config.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getWeekParityExceptions.graphql.dart';

part 'get_week_parity_exceptions_repository.g.dart';

typedef WeekParityExceptions = Query$GetWeekParityExceptions$weekDayException$weekday;

@riverpod
Stream<List<WeekParityExceptions?>?> getWeekParityExceptionsRepository(
    GetWeekParityExceptionsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetWeekParityExceptions(eagerlyFetchResults: true),
    TtlKey.weekParityExceptionsRepository,
  );
  yield* stream.map((event) => event?.weekDayException?.weekday);
}