import "dart:async";
import "dart:io";

import "package:audio_service/audio_service.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:wiredash/wiredash.dart";

import "api_base_rest/client/offline_error.dart";
import "config/env.dart";
import "config/ui_config.dart";
import "config/wiredash.dart";
import "features/analytics/data/app_analytics.dart";
import "features/in_app_review/presentation/in_app_review.dart";
import "features/navigator/app_router.dart";
import "features/navigator/hooks/use_deeplinks.dart";
import "features/navigator/navigation_stack.dart";
import "features/parkings/parkings_view/repository/parkings_repository.dart";
import "features/radio_luz/service/radio_audio_handler.dart";
import "features/radio_luz/service/radio_player_provider.dart";
import "features/splash_screen/splash_screen.dart";
import "features/splash_screen/splash_screen_controller.dart";
import "features/update_dialog/presentation/update_dialog_wrapper.dart";
import "gen/assets.gen.dart";
import "l10n/app_localizations.dart";
import "services/cache_reference_number/cms/presentation/flush_cache_remotely_widget.dart";
import "services/cache_reference_number/translations/presentation/flush_translations_cache_remotely_widget.dart";
import "services/translations_service/data/preferred_lang_repository.dart";
import "services/translations_service/widgets/remove_old_translations.dart";
import "theme/app_theme.dart";

Future<RadioAudioHandlerBridge>? _audioHandlerFuture;

Future<RadioAudioHandlerBridge> _initAudioHandler() {
  return _audioHandlerFuture ??= AudioService.init(
    builder: RadioAudioHandlerBridge.new,
    config: const AudioServiceConfig(
      androidNotificationChannelId: "com.solvro.topwr.audio",
      androidNotificationChannelName: "Audio playback",
      androidNotificationOngoing: true,
    ),
  );
}

Future<void> main({List<Override>? overrides}) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kDebugMode && !kIsWeb) {
    SplashScreenController.preserveNativeSplashScreen();
  }

  if (!kIsWeb) {
    final data = await PlatformAssetBundle().load(Assets.certs.przewodnikPwrEduPl);
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  if (kDebugMode) {
    final audioHandler = await _initAudioHandler();
    runApp(
      ProviderScope(
        retry: (retryCount, error) {
          return null; // no retries in debug mode, to surface errors more quickly
        },
        overrides: [...?overrides, radioPlayerProvider.overrideWithValue(audioHandler)],
        child: const MyApp(),
      ),
    );
  } else {
    String? release;
    if (!kIsWeb) {
      final packageInfo = await PackageInfo.fromPlatform();
      release = "${packageInfo.packageName}@${packageInfo.version}+${packageInfo.buildNumber}";
    }
    await SentryFlutter.init((options) {
      options.dsn = Env.bugsinkDsn;
      if (release != null) {
        options.release = release;
      }
      options.sendDefaultPii = true;
      options.tracesSampleRate = 0;
    }, appRunner: runNormalApp);
  }
}

Future<void> runNormalApp() async {
  final audioHandler = await _initAudioHandler();
  await appAnalytics.initialize(projectId: Env.clarityConfigId);

  runApp(
    ProviderScope(
      retry: (retryCount, error) {
        if (error is ParkingsOfflineException) return null;
        if (error is RestFrameworkOfflineException) return null;
        if (retryCount > 5) return null;
        return Duration(seconds: retryCount * 2);
      },
      overrides: [radioPlayerProvider.overrideWithValue(audioHandler)],
      child: appAnalytics.wrapApp(app: const SplashScreen(child: MyApp())),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(preferredLanguageRepositoryProvider);
    useDeeplinks(ref);

    return RemoveOldTranslations(
      child: FlushCMSCacheRemotelyWidget(
        child: FlushTranslationsCacheRemotelyWidget(
          child: Wiredash(
            projectId: Env.wiredashId,
            secret: Env.wiredashSecret,
            theme: context.wiredashTheme,
            child: MaterialApp.router(
              locale: Locale(currentLocale.value?.name ?? SolvroLocale.pl.name),
              builder: (context, child) => InAppReviewWidget(child: UpdateDialogWrapper(child: child!)),
              title: MyAppConfig.title,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: const AppTheme().light,
              debugShowCheckedModeBanner: false,
              routerConfig: ref
                  .watch(appRouterProvider)
                  .config(navigatorObservers: () => [NavigationObserver(ref, context)]),
            ),
          ),
        ),
      ),
    );
  }
}
