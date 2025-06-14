import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_umami/flutter_umami.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../config/env.dart";
import "../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../navigator/navigation_stack.dart";
import "umami_events.dart";

part "umami.g.dart";

@Riverpod(keepAlive: true)
Future<UmamiCollector> umami(Ref ref) async {
  final locale = await ref.watch(preferredLanguageRepositoryProvider.future) ?? SolvroLocale.pl;
  return FlutterUmami.create(url: Env.umamiUrl, id: Env.umamiId, hostname: "com.solvro.topwr", locale: locale.name);
}

/// utils extensions
extension UmamiTrackEventWidgetRefX on WidgetRef {
  Future<void> trackEvent(UmamiEvents event, {String? value}) async {
    final umami = await read(umamiProvider.future);
    final currentRoute = read(currentRouteProvider);
    await umami.trackEvent(eventType: event.toJson(), eventValue: value, screenName: currentRoute?.settings.name);
  }
}

extension UmamiTrackEventRefX on Ref {
  Future<void> trackEvent(UmamiEvents event, {String? value}) async {
    final umami = await read(umamiProvider.future);
    final currentRoute = read(currentRouteProvider);
    await umami.trackEvent(eventType: event.toJson(), eventValue: value, screenName: currentRoute?.settings.name);
  }
}
