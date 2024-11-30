import "dart:core";

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";
import "package:lottie/lottie.dart";

import "../../../../theme/app_theme.dart";
import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../home_view/widgets/paddings.dart";
import "../../sks_people_live/presentation/widgets/sks_user_data_button.dart";
import "../data/models/sks_menu_response.dart";
import "../data/repository/sks_menu_repository.dart";
import "widgets/sks_menu_data_source_link.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";

@RoutePage()
class SksMenuView extends ConsumerWidget {
  const SksMenuView({
    super.key,
    this.appBarPopTitle,
  });
  final String? appBarPopTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksMenuData = ref.watch(getSksMenuDataProvider);
    final isLastMenuButtonClicked = ref.watch(isLastMenuButtonClickedProvider);
    final previousSksMenuData = ref.watch(previousSksMenuDataProvider);

    return asyncSksMenuData.when(
      data: (sksMenuData) {
        Logger().d("Fetched SKS Menu Data: $sksMenuData");
        Logger().d("Previous menu data: $previousSksMenuData");
        Logger().d("Is last menu button clicked: $isLastMenuButtonClicked");

        if (!sksMenuData.isMenuOnline && !isLastMenuButtonClicked) {
          return _SKSMenuLottieAnimation(
            onShowLastMenuTap: () {
              ref.read(isLastMenuButtonClickedProvider.notifier).state = true;
              ref.read(previousSksMenuDataProvider.notifier).state =
                  sksMenuData;
              Logger().d("Switched to last menu view");
            },
          );
        }

        if (isLastMenuButtonClicked && previousSksMenuData != null) {
          return _SksMenuView(previousSksMenuData, appBarPopTitle);
        }

        return _SksMenuView(sksMenuData, appBarPopTitle);
      },
      error: (error, stackTrace) {
        Logger().e("Error loading menu: $error");
        Logger().e("Stack trace: $stackTrace");

        if (isLastMenuButtonClicked && previousSksMenuData != null) {
          return _SksMenuView(previousSksMenuData, appBarPopTitle);
        }

        return _SKSMenuLottieAnimation(
          error: error,
          onShowLastMenuTap: () {
            ref.read(isLastMenuButtonClickedProvider.notifier).state = true;
            Logger().d("Error occurred. Switching to last menu view.");
          },
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _SksMenuView extends StatelessWidget {
  const _SksMenuView(this.sksMenuData, this.appBarPopTitle);

  final SksMenuResponse sksMenuData;
  final String? appBarPopTitle;
  @override
  Widget build(BuildContext context) {
    Logger().d("Rendering menu view. Menu data: $sksMenuData");

    if (!sksMenuData.isMenuOnline) {
      return const _SKSMenuLottieAnimation();
    }
    return Scaffold(
      appBar: DetailViewAppBar(
        title: appBarPopTitle ?? context.localize.home_screen,
        actions: const [
          SksUserDataButton(),
        ],
      ),
      body: ListView(
        children: [
          SksMenuHeader(
            dateTimeOfLastUpdate: sksMenuData.lastUpdate.toIso8601String(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: HomeViewConfig.paddingMedium,
            ),
            child: MediumHorizontalPadding(
              child: SksMenuSection(sksMenuData.meals),
            ),
          ),
          const SksMenuDataSourceLink(),
          const SizedBox(
            height: ScienceClubsViewConfig.mediumPadding,
          ),
        ],
      ),
    );
  }
}

class _SKSMenuLottieAnimation extends StatelessWidget {
  const _SKSMenuLottieAnimation({
    this.error,
    this.onShowLastMenuTap,
  });

  final Object? error;
  final VoidCallback? onShowLastMenuTap;
  @override
  Widget build(BuildContext context) {
    if (error != null) {
      Logger().e(error.toString());
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 200,
            child: Lottie.asset(
              Assets.animations.sksClosed,
              fit: BoxFit.cover,
              repeat: false,
              frameRate: const FrameRate(LottieAnimationConfig.frameRate),
              renderCache: RenderCache.drawingCommands,
            ),
          ),
          Align(
            child: Text(
              context.localize.sks_menu_closed,
              style: context.textTheme.headline,
              textAlign: TextAlign.center,
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                error.toString(),
                style: context.textTheme.titleGrey,
                textAlign: TextAlign.center,
              ),
            ),
          if (onShowLastMenuTap != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  Logger().d("Show last menu button clicked");
                  onShowLastMenuTap?.call();
                },
                child: Text(
                  context.localize.sks_show_last_menu,
                  style: context.textTheme.bodyOrange,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
