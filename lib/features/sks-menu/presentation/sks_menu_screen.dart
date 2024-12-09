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
import "../../../widgets/my_text_button.dart";
import "../../sks_people_live/presentation/widgets/sks_user_data_button.dart";
import "../data/models/sks_menu_response.dart";
import "../data/repository/sks_menu_repository.dart";
import "widgets/sks_menu_data_source_link.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";
import "widgets/sks_menu_view_loading.dart";
import "widgets/technical_message.dart";

@RoutePage()
class SksMenuView extends HookConsumerWidget {
  const SksMenuView({super.key});

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
          isLastMenuButtonClicked: isLastMenuButtonClicked.value,
        );
      },
      error: (error, stackTrace) => _SKSMenuLottieAnimation(error: error),
      loading: () => const Scaffold(
        body: Center(
          child: SksMenuViewLoading(),
        ),
      ),
    );
  }
}

class _SksMenuView extends StatelessWidget {
  const _SksMenuView({
    required this.sksMenuData,
    required this.isLastMenuButtonClicked,
  });

  final ExtendedSksMenuResponse sksMenuData;
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
          if (!sksMenuData.isMenuOnline)
            TechnicalMessage(
              color: context.colorTheme.blueAzure,
              title: context.localize.sks_note,
              message: context.localize.sks_menu_you_see_last_menu,
            ),
          for (final technicalInfo in sksMenuData.technicalInfos)
            TechnicalMessage(message: technicalInfo),
          SksMenuHeader(
            dateTimeOfLastUpdate: sksMenuData.lastUpdate.toIso8601String(),
          ),
          Padding(
            padding: const EdgeInsets.all(HomeViewConfig.paddingMedium),
            child: SksMenuSection(sksMenuData.meals),
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
    final animationSize = MediaQuery.sizeOf(context).width * 0.6;

    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: DetailViewAppBar(
        actions: const [
          SksUserDataButton(),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox.square(
              dimension: animationSize,
              child: Lottie.asset(
                Assets.animations.sksClosed,
                fit: BoxFit.cover,
                repeat: false,
                frameRate: const FrameRate(LottieAnimationConfig.frameRate),
                renderCache: RenderCache.drawingCommands,
                onLoaded: (composition) {
                  final totalDuration = composition.duration;
                  Future.delayed(
                      totalDuration *
                          0.8, // in my opinion the animation is a bit boring at the end, so we can show the texts a bit earlier
                      () {
                    isAnimationCompleted.value = true;
                  });
                },
              ),
            ),
            Opacity(
              opacity: isAnimationCompleted.value ? 1 : 0,
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(animationSize *
                      0.10), // the animation has some extra space at the bottom
                ),
                child: Column(
                  children: [
                    Text(
                      context.localize.sks_menu_closed,
                      style: context.textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (error != null)
                      Text(
                        error.toString(),
                        style: context.textTheme.titleGrey,
                        textAlign: TextAlign.center,
                      ),
                    if (onShowLastMenuTap != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: MyTextButton(
                          actionTitle: context.localize.sks_show_last_menu,
                          onClick: onShowLastMenuTap,
                          showBorder: true,
                          color: context.colorTheme.blueAzure,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
