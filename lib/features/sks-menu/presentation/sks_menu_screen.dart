import "dart:core";

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
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
class SksMenuView extends HookConsumerWidget {
    const SksMenuView({super.key});

  final String? appBarPopTitle;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksMenuData = ref.watch(getSksMenuDataProvider);
    final isLastMenuButtonClicked = useState(false);

    return asyncSksMenuData.when(
      data: (sksMenuData) {
        if (!sksMenuData.isMenuOnline && !isLastMenuButtonClicked.value) {
          return _SKSMenuLottieAnimation(
            onShowLastMenuTap: () {
              isLastMenuButtonClicked.value = true;
            },
          );
        }
        return _SksMenuView(
          sksMenuData: sksMenuData,
          appBarPopTitle: appBarPopTitle,
          isLastMenuButtonClicked: isLastMenuButtonClicked.value,
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
  const _SksMenuView({
    required this.sksMenuData,
    this.appBarPopTitle,
    required this.isLastMenuButtonClicked,
  });

  final SksMenuResponse sksMenuData;
  final String? appBarPopTitle;
  final bool isLastMenuButtonClicked;

  @override
  Widget build(BuildContext context) {
    if (!isLastMenuButtonClicked && !sksMenuData.isMenuOnline) {
      return const _SKSMenuLottieAnimation();
    }
    return Scaffold(
      appBar: DetailViewAppBar(
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

class _SKSMenuLottieAnimation extends HookWidget {
  const _SKSMenuLottieAnimation({
    this.error,
    this.onShowLastMenuTap,
  });

  final Object? error;
  final VoidCallback? onShowLastMenuTap;

  @override
  Widget build(BuildContext context) {
    final isAnimationCompleted = useState(false);

    if (error != null) {
      Logger().e(error.toString());
    }

    return Scaffold(
       appBar: DetailViewAppBar(
        actions: const [
          SksUserDataButton(),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              if (isAnimationCompleted.value)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    context.localize.sks_menu_closed,
                    style: context.textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (error != null && isAnimationCompleted.value)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    error.toString(),
                    style: context.textTheme.titleGrey,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (onShowLastMenuTap != null && isAnimationCompleted.value)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: onShowLastMenuTap,
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
                    isAnimationCompleted.value = true;
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
