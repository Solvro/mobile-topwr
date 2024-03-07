import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';
import 'getInfosPreview.graphql.dart';

part 'infos_preview_repository.g.dart';

typedef InfosPreview = Query$GetInfosPreview$infos;

@riverpod
Stream<List<InfosPreview?>?> infosPreviewRepository(
    InfosPreviewRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetInfosPreview(eagerlyFetchResults: true),
    "InfosPreviewRepositoryRef",
  );
  yield* stream.map((event) => event?.infos);
}
