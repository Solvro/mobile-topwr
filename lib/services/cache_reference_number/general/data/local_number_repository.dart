import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../../../../config/shared_prefs.dart";

mixin LocalCacheRefNumberRepositoryMixin on $AsyncNotifier<int?> {
  String get prefsKEY;

  Future<SharedPreferences> get _sharedPrefs async => ref.watch(sharedPreferencesSingletonProvider.future);

  FutureOr<int?> build() async {
    return (await _sharedPrefs).getInt(prefsKEY);
  }

  Future<void> saveNumber(int number) async {
    await (await _sharedPrefs).setInt(prefsKEY, number);
    state = AsyncValue.data(number);
  }
}
