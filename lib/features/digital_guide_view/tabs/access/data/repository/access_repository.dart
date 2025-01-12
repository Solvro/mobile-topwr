import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../../data/models/access.dart";

part "access_repository.g.dart";

@riverpod
Future<List<Access>> accessRepository(
    Ref ref,
    List<int> buildingIds,
    ) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] = "Token ${Env.digitalGuideUrl}";

  final List<Access> accessDataList = [];

  for (final buildingId in buildingIds) {
    final accessDetailsURL = "${Env.digitalGuideUrl}/access/$buildingId";
    final response = await dio.get(accessDetailsURL);

    final accessData = Access.fromJson(
      response.data as Map<String, dynamic>,
    );

    accessDataList.add(accessData);
  }

  return accessDataList;
}
