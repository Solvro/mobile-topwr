import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:topwr/api_base/env.dart';

final gqlClientProvider = Provider((ref) async {
  return GraphQLClient(
    cache: GraphQLCache(),
    link: AuthLink(
      getToken: () => "Bearer ${Env.apiKey}",
    ).concat(
      HttpLink(Env.apiUrl),
    ),
  );
});
