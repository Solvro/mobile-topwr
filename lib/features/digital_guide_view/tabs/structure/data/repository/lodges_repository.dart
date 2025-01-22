import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/api/digital_guide_get_and_cache.dart";
import "../models/lodge.dart";

part "lodges_repository.g.dart";

@riverpod
Future<IList<Lodge>> lodgesRepository(
  Ref ref,
  List<int> lodgesIDs,
) async {
  Future<Lodge> getLodge(int lodgeID) async {
    return ref.getAndCacheDataFromDigitalGuide(
      "lodges/$lodgeID",
      Lodge.fromJson,
      onRetry: () => ref.invalidateSelf(),
    );
  }

  final lodges = await Future.wait(lodgesIDs.map(getLodge));

  return lodges.lock;
}
