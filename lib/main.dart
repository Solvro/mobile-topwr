import "dart:async";
import "dart:io";

import "package:clarity_flutter/clarity_flutter.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:wiredash/wiredash.dart";

import "config/env.dart";
import "config/ui_config.dart";
import "config/wiredash.dart";
import "features/in_app_review/presentation/in_app_review.dart";
import "features/navigator/app_router.dart";
import "features/navigator/navigation_stack.dart";
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
  try {
    await JustAudioBackground.init(
      androidNotificationChannelId: "com.solvro.topwr.audio",
      androidNotificationChannelName: "Audio playback",
      androidNotificationOngoing: true,
      showStopAction: false,
    );
  } on PlatformException catch (e, st) {
    await Sentry.captureException(e, stackTrace: st);
  }

  final config = ClarityConfig(
    projectId: Env.clarityConfigId,
    logLevel: LogLevel.None, // Note: Use "LogLevel.Verbose" value while testing to debug initialization issues.
  );

  return runApp(
    ClarityWidget(
      clarityConfig: config,
      app: const ProviderScope(child: SplashScreen(child: MyApp())),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(preferredLanguageRepositoryProvider);

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
