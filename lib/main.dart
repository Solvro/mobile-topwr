import "dart:async";
import "dart:io";

import "package:audio_service/audio_service.dart";
import "package:clarity_flutter/clarity_flutter.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:wiredash/wiredash.dart";

import "api_base_rest/client/offline_error.dart";
import "config/env.dart";
import "config/ui_config.dart";
import "config/wiredash.dart";
import "features/in_app_review/presentation/in_app_review.dart";
import "features/navigator/app_router.dart";
import "features/navigator/hooks/use_deeplink_listener.dart";
import "features/navigator/navigation_stack.dart";
import "features/parkings/parkings_view/api_client/iparking_commands.dart";
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SplashScreenController.preserveNativeSplashScreen();
  if (kDebugMode) {
    return runToPWR();
  } else {
    await SentryFlutter.init((options) {
      options.dsn = Env.bugsinkDsn;
      options.sendDefaultPii = true;
      options.tracesSampleRate = 0;
    }, appRunner: runToPWR);
  }
}

Future<void> runToPWR() async {
  final data = await PlatformAssetBundle().load(Assets.certs.przewodnikPwrEduPl);
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  // await setupParkingWidgetsWorkManager();

  final config = ClarityConfig(projectId: Env.clarityConfigId, logLevel: LogLevel.None);

  final audioHandler = await AudioService.init(
    builder: RadioAudioHandlerBridge.new,
    config: const AudioServiceConfig(
      androidNotificationChannelId: "com.solvro.topwr.audio",
      androidNotificationChannelName: "Audio playback",
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );

  return runApp(
    ClarityWidget(
      clarityConfig: config,
      app: ProviderScope(
        retry: (retryCount, error) {
          if (error is ParkingsOfflineException) return null;
          if (error is RestFrameworkOfflineException) return null;
          if (retryCount > 5) return null;
          return Duration(seconds: retryCount * 2);
        },
        overrides: [radioPlayerProvider.overrideWithValue(audioHandler)],
        child: const SplashScreen(child: MyApp()),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(preferredLanguageRepositoryProvider);
    useDeeplinkListener(ref);
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
              routerConfig: ref.watch(appRouterProvider).config(navigatorObservers: () => [NavigationObserver(ref)]),
            ),
          ),
        ),
      ),
    );
  }
}
