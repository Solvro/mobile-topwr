import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../api_base/watch_query_adapter.dart';
import '../../../../../config/ttl_config.dart';
import 'getAboutUsDetails.graphql.dart';

part 'about_us_repository.g.dart';

typedef _GetAboutUs = WatchOptions$Query$getAbousUsDetails;
typedef AboutUs = Query$getAbousUsDetails$AboutUs;

@riverpod
Stream<AboutUs?> aboutUsRepository(AboutUsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    _GetAboutUs(
      eagerlyFetchResults: true,
    ),
    TtlKey.aboutUsRepository,
  );
  yield* stream.map((event) => event?.AboutUs);
}
