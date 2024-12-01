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

    return asyncSksMenuData.when(
      data: (sksMenuData) {
        Logger().d("Fetched SKS Menu Data: $sksMenuData");
        Logger().d("Is last menu button clicked: $isLastMenuButtonClicked");

        if (!sksMenuData.isMenuOnline && !isLastMenuButtonClicked) {
          return _SKSMenuLottieAnimation(
            onShowLastMenuTap: () {
              ref.read(isLastMenuButtonClickedProvider.notifier).setClicked();
              Logger().d("Switched to last menu view");
            },
          );
        }
        if (sksMenuData.isMenuOnline && isLastMenuButtonClicked) {
          ref.read(isLastMenuButtonClickedProvider.notifier).resetClicked();
        }
        return _SksMenuView(
          sksMenuData,
          appBarPopTitle,
          isLastMenuButtonClicked,
        );
      },
      error: (error, stackTrace) => _SKSMenuLottieAnimation(error: error),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _SksMenuView extends StatelessWidget {
  const _SksMenuView(
      this.sksMenuData, this.appBarPopTitle, this.isLastMenuButtonClicked);

  final SksMenuResponse sksMenuData;
  final String? appBarPopTitle;
  final bool isLastMenuButtonClicked;

  @override
  Widget build(BuildContext context) {
    Logger().d("Rendering menu view. Menu data: $sksMenuData");

    if (!isLastMenuButtonClicked && !sksMenuData.isMenuOnline) {
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

class _SKSMenuLottieAnimation extends ConsumerWidget {
  const _SKSMenuLottieAnimation({
    this.error,
    this.onShowLastMenuTap,
  });

  final Object? error;
  final VoidCallback? onShowLastMenuTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnimationCompleted = ref.watch(lottieAnimationCompletedProvider);

    if (error != null) {
      Logger().e(error.toString());
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              if (isAnimationCompleted)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    context.localize.sks_menu_closed,
                    style: context.textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (error != null && isAnimationCompleted)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    error.toString(),
                    style: context.textTheme.titleGrey,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (onShowLastMenuTap != null && isAnimationCompleted)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Logger().d("Show last menu button clicked");
                      onShowLastMenuTap?.call();
                    },
                    child: Text(
                      context.localize.sks_show_last_menu,
                      style: context.textTheme.lightTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox.square(
              dimension: 200,
              child: Lottie.asset(
                Assets.animations.sksClosed,
                fit: BoxFit.cover,
                repeat: false,
                frameRate: const FrameRate(LottieAnimationConfig.frameRate),
                renderCache: RenderCache.drawingCommands,
                onLoaded: (composition) {
                  final totalDuration = composition.duration;
                  Future.delayed(totalDuration, () {
                    ref
                        .read(lottieAnimationCompletedProvider.notifier)
                        .setAnimationCompleted();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
