import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';
import '../../../config/ttl_config.dart';
import 'getGuide.graphql.dart';

part 'guide_repository.g.dart';

typedef Infos = Query$GetGuide$FAQ_Types;

@riverpod
Stream<List<Infos?>?> guideRepository(GuideRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetGuide(eagerlyFetchResults: true),
    TtlKey.guideRepository,
  );
  yield* stream.map((event) => event?.FAQ_Types);
}
