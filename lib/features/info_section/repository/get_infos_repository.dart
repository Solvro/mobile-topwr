import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';

import 'getInfos.graphql.dart';
import '../../../config/ttl_config.dart';
part 'get_infos_repository.g.dart';

typedef Infos = Query$GetGuideInfo$FAQ_Types;

@riverpod
Stream<List<Infos?>?> infosRepository(InfosRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetGuideInfo(eagerlyFetchResults: true),
    TtlKey.infosRepository,
  );
  yield* stream.map((event) => event?.FAQ_Types);
}
