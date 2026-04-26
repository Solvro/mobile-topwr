import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/theme/app_theme.dart";
import "package:widgetbook/widgetbook.dart";

import "components.g.dart";

final config = Config(
  components: components,
  addons: [AlignmentAddon()],
  appBuilder: (context, child) {
    final fallbackAssetBundle = _TopwrFallbackAssetBundle(rootBundle);
    return ProviderScope(
      child: DefaultAssetBundle(
        bundle: fallbackAssetBundle,
        child: Theme(
          data: const AppTheme().light,
          child: Material(child: child),
        ),
      ),
    );
  },
);

class _TopwrFallbackAssetBundle extends CachingAssetBundle {
  _TopwrFallbackAssetBundle(this._delegate);

  final AssetBundle _delegate;

  static const _topwrPackagePrefix = "packages/topwr/";

  @override
  Future<ByteData> load(String key) async {
    try {
      return await _delegate.load(key);
    } catch (_) {
      if (key.startsWith(_topwrPackagePrefix)) rethrow;
      return _delegate.load("$_topwrPackagePrefix$key");
    }
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    try {
      return await _delegate.loadString(key, cache: cache);
    } catch (_) {
      if (key.startsWith(_topwrPackagePrefix)) rethrow;
      return _delegate.loadString("$_topwrPackagePrefix$key", cache: cache);
    }
  }
}
