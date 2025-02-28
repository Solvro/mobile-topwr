import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../../config/shared_prefs.dart";

part "local_cache_ref_number_repo.g.dart";

const _prefsKEY = r"$$$_cacheReferenceNumber";

@riverpod
class LocalCacheRefNumberRepo extends _$LocalCacheRefNumberRepo {
  Future<SharedPreferences> get _sharedPrefs async => ref.watch(sharedPreferencesSingletonProvider.future);

  @override
  FutureOr<int?> build() async {
    return (await _sharedPrefs).getInt(_prefsKEY);
  }

  Future<void> saveNumber(int number) async {
    await (await _sharedPrefs).setInt(_prefsKEY, number);
  }
}
