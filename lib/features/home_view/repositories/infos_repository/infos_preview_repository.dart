import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../api_base/gql_client_provider.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getInfosPreview.graphql.dart';

part 'infos_preview_repository.g.dart';



typedef InfosPreview = Query$GetInfosPreview$infos;

@riverpod
Stream<List<InfosPreview?>?> infosPreviewRepository (InfosPreviewRepositoryRef ref)  async*{
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
    client,
    WatchOptions$Query$GetInfosPreview(
      eagerlyFetchResults: true
    ),
  );
  yield* stream.map((event) => event?.infos);
}
