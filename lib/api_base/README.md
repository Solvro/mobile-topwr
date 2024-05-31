# Our Graphql API Helper module (now with Cache and TTL)

I've configured the graphql and graphql_codegen packages along with a persistent on-disk cache based on Hive.

This setup employs code generation to create type-safe models from GraphQL queries. This approach allows us to pass parameters and receive results in a type-safe manner.

However, to facilitate serving data from the cache and subsequently updating it with the latest network data as soon as it becomes available, these packages base their api on streams. Consequently, the usage becomes a bit more complex than without caching. But I've tried to simplify this process as much as possible to minimalize boilerplate code. Let's see fully working example on how you can utilize this small module to download data from server.

# Setup

Before you start, you need to add `.env` file to project's root with appropriate content:

```bash
API_URL="https://<our-server-url>/graphql"
ASSETS_URL="https://<our-server-url>/assets"
IPARKING_URL="https://<secret parking's source>.pl"
```

## Example

1. `get_departments.graphql`

   - Based on this query, codebuilder builds our ready-to-use models with proper types and parameters, even converting dates to DateTime.

   ```graphql
   query GetDepartments {
     departments {
       name
       updated_at
       code
     }
   }
   ```

2. `lib\api_base\ttl\ttl_config.dart`
  -  **TTL Note**: Now every repository need to have its own `TtlKey` enumerations literal. You need to add one in `lib\api_base\ttl\ttl_config.dart` to `enum TtlKey`, rebuild code generation and add TTL duration to `TTLStrategy` generated map.

modify this:
```dart
@unmodifiableEnumMap
enum TtlKey {
  //..
  departmentsRepository, // add this new key
}

abstract class TtlStrategy {
  static const _values = UnmodifiableTtlKeyMap(
    // ..
    departmentsRepository: Duration(days: 28),
  );
  //..
}
```



2. `departments_repository.dart`:

   - This is example of our repository. It won't be much different for most of our simple fetch-only repositories. I've simplified the process as much as I could. Hopefully without limiting possibilities.
     



 
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';
import "../../api_base/ttl/ttl_config.dart";
import 'getDepartments.graphql.dart';

part 'departments_repository.g.dart';

typedef Department
    = Query$GetDepartments$departments; // just alias for shorter type name

@riverpod
Stream<List<Department?>?> departmentsRepository(
    DepartmentsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetDepartments(
      eagerlyFetchResults: true,
    ),
    TtlKey.departmentsRepository,
  );
  yield* stream.map(
    (event) => event?.departments,
  );
}

   ```

3. `departments_view.dart`:
   Below very simple view with our repo usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository/departments_repository.dart';

class DepartmentsView extends ConsumerWidget {
  const DepartmentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncError(:final error) => Text(error.toString()),
      AsyncValue(:final value) => ListView(
          children: [
            for (final department in value ?? []) Text(department?.name ?? ""),
          ],
        )
    };
  }
}
```

# How not to use this package and what has been sacrified for cache capabilities

Below is a brief example of what would be different without caching data in the local database. However, I believe offline caching is extra nice due to the specifications of this tour-guide app. Therefore, it is preferable to use the approach from the example above, not the one below:

```dart
@riverpod
Future<List<Department?>> departmentsRepositoryOnlyNetwork(
  DepartmentsRepositoryOnlyNetworkRef ref,
) async {
  final client = await ref.watch(gqlClientProvider);
  // I changed client.query default behaviour to no caching, so now it always makes network request.
  final query = await client.query$GetDepartments();
  return query.parsedData?.departments ?? [];
}

```
