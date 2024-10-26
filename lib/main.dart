import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wiredash/wiredash.dart";

import "api_base/cache/remote_flush/presentation/flush_cache_remotely_widget.dart";
import "config/env.dart";
import "config/ui_config.dart";
import "config/wiredash.dart";
import "features/in_app_review/in_app_review.dart";
import "features/navigator/app_router.dart";
import "features/navigator/navigation_controller.dart";
import "features/splash_screen/splash_screen.dart";
import "features/splash_screen/splash_screen_controller.dart";
import "features/update_dialog/presentation/update_dialog_wrapper.dart";
import "theme/app_theme.dart";
import "theme/colors.dart";

void main() {
  SplashScreenController.preserveNativeSplashScreen();
  runApp(
    const ProviderScope(
      child: SplashScreen(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlushCacheRemotelyWidget(
      child: Wiredash(
        projectId: Env.wiredashId,
        secret: Env.wiredashSecret,
        theme: context.wiredashTheme,
        child: MaterialApp.router(
          builder: (context, child) => InAppReviewWidget(
            child: UpdateDialogWrapper(
              child: child!,
            ),
          ),
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
          routerConfig: ref.watch(appRouterProvider).config(
            deepLinkTransformer: (uri) {
              Future.delayed(
                const Duration(milliseconds: 500),
                ref.read(navigationControllerProvider.notifier).refreshState,
              ); // TODO(simon-the-shark): remove this nasty workaround for active tab refresh
              return SynchronousFuture(uri);
            },
          ),
        ),
      ),
    );
  }
}
