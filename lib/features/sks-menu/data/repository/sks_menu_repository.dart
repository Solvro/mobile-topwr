import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/sks_menu_response.dart";

part "sks_menu_repository.g.dart";

@riverpod
Future<SksMenuResponse> getSksMenuData(Ref ref) async {
  final mealsUrl = "${Env.sksUrl}/meals/current";

  final dio = ref.read(restClientProvider);
  final response = await dio.get(mealsUrl);
  final SksMenuResponse sksMenuResponse =
      SksMenuResponse.fromJson(response.data as Map<String, dynamic>);

  return sksMenuResponse;
}
