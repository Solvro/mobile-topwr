import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../config/env.dart";

part "translation_client.g.dart";

@riverpod
Dio translationsClient(Ref ref) =>
    Dio(BaseOptions(baseUrl: Env.translateApiUrl, headers: {"x-api-token": Env.translateApiToken}));
