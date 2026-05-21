import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/env.dart";
import "../../../config/shared_prefs.dart";

part "feature_codes_repository.g.dart";

@riverpod
IList<String> defaultFeatureCodes(Ref ref) {
  return Env.defaultFeatureCodes.split(",").map((code) => code.trim()).where((code) => code.isNotEmpty).toIList();
}

@riverpod
class FeatureCodesRepository extends _$FeatureCodesRepository {
  static const _prefsKey = "__feature_codes__";

  @override
  ISet<String> build() {
    final defaults = ref.watch(defaultFeatureCodesProvider);
    final prefs = ref.watch(sharedPreferencesSingletonProvider);

    return switch (prefs) {
      AsyncData(:final value) => () {
        final stored = value.getStringList(_prefsKey) ?? const <String>[];
        if (!value.containsKey(_prefsKey) && defaults.isNotEmpty) {
          final seeded = defaults.toISet();
          unawaited(value.setStringList(_prefsKey, seeded.toList()));
          return seeded;
        }
        return stored.where((code) => code.trim().isNotEmpty).toISet();
      }(),
      AsyncLoading() || AsyncError() => defaults.toISet(),
    };
  }

  Future<void> addCode(String code) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) return;
    final next = state.add(trimmed);
    state = next;
    await _save(next);
  }

  Future<void> removeCode(String code) async {
    final next = state.remove(code);
    state = next;
    await _save(next);
  }

  Future<void> _save(ISet<String> codes) async {
    final prefs = await ref.read(sharedPreferencesSingletonProvider.future);
    await prefs.setStringList(_prefsKey, codes.toList());
  }
}
