import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

extension WatchQueryStreamAdapter on Ref {
  Stream<T?> watchQueryWithCache<T>(
    GraphQLClient client,
    WatchQueryOptions<T> watchQueryOptions,
  ) {
    final observableQuery = client.watchQuery(watchQueryOptions);
    onDispose(observableQuery.close);
    return observableQuery.stream
        .where(
          (event) => event.isNotLoading,
        )
        .map(
          (event) => event.parsedData,
        );
  }
}
