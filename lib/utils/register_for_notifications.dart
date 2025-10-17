import "package:flutter_riverpod/flutter_riverpod.dart";

import "../api_base_rest/client/dio_client.dart";
import "../config/env.dart";

Future<void> registerForNotifications(Ref ref) async {
  final client = ref.read(restClientProvider);
  final url = "${Env.sksUrl}/device/registration-token";
  await client.put<Map<String, dynamic>>(url, data: {"deviceKey": "aa", "registrationToken": "bb"});
}
