import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_umami/flutter_umami.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:wiredash/wiredash.dart";

import "api_base/cache/remote_flush/presentation/flush_cache_remotely_widget.dart";
import "config/env.dart";
import "config/ui_config.dart";
import "config/wiredash.dart";
import "features/analytics/data/umami.dart";
import "features/in_app_review/presentation/in_app_review.dart";
import "features/navigator/app_router.dart";
import "features/navigator/navigation_stack.dart";
import "features/splash_screen/splash_screen.dart";
import "features/splash_screen/splash_screen_controller.dart";
import "features/update_dialog/presentation/update_dialog_wrapper.dart";
import "l10n/app_localizations.dart";
import "services/translations_service/data/preferred_lang_repository.dart";
import "services/translations_service/widgets/remove_old_translations.dart";
import "theme/app_theme.dart";
import "theme/colors.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SplashScreenController.preserveNativeSplashScreen();
  await SentryFlutter.init((options) {
    options.dsn = Env.bugsinkDsn;
    options.sendDefaultPii = true;
    options.tracesSampleRate = 0;
  }, appRunner: () => runApp(const ProviderScope(child: SplashScreen(child: MyApp()))));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(preferredLanguageRepositoryProvider);

    return RemoveOldTranslations(
      child: FlushCacheRemotelyWidget(
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
            theme: ThemeData(
              extensions: const [AppTheme()],
              colorScheme: const ColorScheme.light().copyWith(
                surface: ColorsConsts.whiteSoap,
                primary: ColorsConsts.orangePomegranade,
                secondary: ColorsConsts.blueAzure,
              ),
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: ref
                .watch(appRouterProvider)
                .config(
                  navigatorObservers:
                      () => [
                        NavigationObserver(ref),
                        UmamiNavigationObserver(Future.microtask(() async => ref.watch(umamiProvider.future))),
                      ],
                ),
          ),
        ),
      ),
    );
  }
}
