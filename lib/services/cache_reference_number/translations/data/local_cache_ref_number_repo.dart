import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../general/data/local_number_repository.dart";

part "local_cache_ref_number_repo.g.dart";

@riverpod
class LocalTranslatorRefNumberRepo extends _$LocalTranslatorRefNumberRepo with LocalCacheRefNumberRepositoryMixin {
  @override
  String get prefsKEY => r"$$$_translatorReferenceNumber";

  @override
  // ignore: unnecessary_overrides, needed for riverpod builder
  FutureOr<int?> build() async {
    return super.build();
  }
}
