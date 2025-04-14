// ! TEMPORARY UTILS FILE FOR TRANSLATING GRAPHQL DATA
// We're gonna drop GraphQL and use REST API for fetching data so no need to have fancy utils here
// So let's keep it simple for now

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../services/translations_service/business/translator_provider.dart";
import "../../services/translations_service/data/repositories/preferred_lang_repository.dart";

extension TranslateGraphQL on Ref {
  Future<String> translateGraphQLString(String data) async {
    final translator = watch(solvroTranslatorProvider);
    final locale = await watch(preferredLanguageRepositoryProvider.future);
    return translator.translate(data, locale);
  }

  Future<String?> translateGraphQLMaybeString(String? data) async {
    if (data == null) return null;
    return translateGraphQLString(data);
  }

  Future<IList<T>> translateGraphQLModelIList<T>(IList<T> models, Future<T> Function(T model) translateFunction) async {
    return (await Future.wait(models.map(translateFunction))).toIList();
  }

  Future<List<T>> translateGraphQLModelList<T>(List<T> models, Future<T> Function(T model) translateFunction) async {
    return (await Future.wait(models.map(translateFunction))).toList();
  }
}
