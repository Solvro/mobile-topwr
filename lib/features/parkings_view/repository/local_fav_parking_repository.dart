import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/shared_prefs.dart";

part "local_fav_parking_repository.g.dart";

@riverpod
class LocalFavParkingsRepository extends _$LocalFavParkingsRepository {
  static const _repoPrefix = "fav_parking_";

  String get _key => _repoPrefix + parkingId;

  @override
  bool? build(String parkingId) {
    final prefs = ref.watch(sharedPreferencesSingletonProvider);
    return switch (prefs) {
      AsyncError() => null,
      AsyncValue(:final value) => value?.getBool(_key) ?? false,
    };
  }

  Future<void> toggle() async {
    final currState = state ?? false;
    final newState = !currState;
    state = newState;
    final prefs = await ref.read(sharedPreferencesSingletonProvider.future);
    await prefs.setBool(_key, newState);
  }
}
