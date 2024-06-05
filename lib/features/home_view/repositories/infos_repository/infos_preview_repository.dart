import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../config/ttl_config.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getInfosPreview.graphql.dart';

part 'infos_preview_repository.g.dart';

typedef InfosPreview = Query$GetInfosPreview$Posts;

@riverpod
Stream<List<InfosPreview?>?> infosPreviewRepository(
    InfosPreviewRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetInfosPreview(eagerlyFetchResults: true),
    TtlKey.infosPreviewRepository,
  );
  yield* stream.map((event) => event?.Posts);
}
