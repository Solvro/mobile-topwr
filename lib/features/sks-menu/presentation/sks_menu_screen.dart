import "dart:core";
import "dart:math";

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:lottie/lottie.dart";

import "../../../../theme/app_theme.dart";
import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/my_text_button.dart";
import "../../../widgets/text_and_url_widget.dart";
import "../../sks_people_live/presentation/widgets/sks_user_data_button.dart";
import "../data/models/sks_menu_response.dart";
import "../data/repository/sks_menu_repository.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";
import "widgets/sks_menu_view_loading.dart";
import "widgets/technical_message.dart";

@RoutePage()
class SksMenuView extends HookConsumerWidget {
  const SksMenuView({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(
      context.localize.sks_menu,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksMenuData = ref.watch(sksMenuRepositoryProvider);
    final isLastMenuButtonClicked = useState(false);

    return asyncSksMenuData.when(
      data: (sksMenuData) {
        if (!sksMenuData.isMenuOnline && !isLastMenuButtonClicked.value) {
          return _SKSMenuUnavailableAnimation(
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
      error: (error, stackTrace) => HorizontalSymmetricSafeAreaScaffold(
        appBar: DetailViewAppBar(
          actions: const [
            SksUserDataButton(),
          ],
        ),
        body: MyErrorWidget(error),
      ),
      loading: () => HorizontalSymmetricSafeAreaScaffold(
        body: const Center(
          child: SksMenuViewLoading(),
        ),
      ),
    );
  }
}

class _SksMenuView extends ConsumerWidget {
  const _SksMenuView({
    required this.sksMenuData,
    required this.isLastMenuButtonClicked,
  });

  final ExtendedSksMenuResponse sksMenuData;
  final bool isLastMenuButtonClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isLastMenuButtonClicked && !sksMenuData.isMenuOnline) {
      return const _SKSMenuUnavailableAnimation();
    }
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(
        actions: const [
          SksUserDataButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(sksMenuRepositoryProvider.notifier).clearCache();
          return ref.refresh(sksMenuRepositoryProvider.future);
        },
        color: context.colorTheme.orangePomegranade,
        child: ListView(
          children: [
            if (!sksMenuData.isMenuOnline)
              TechnicalMessage(
                alertType: AlertType.info,
                title: context.localize.sks_note,
                message: context.localize.sks_menu_you_see_last_menu,
              ),
            for (final technicalInfo in sksMenuData.technicalInfos)
              TechnicalMessage(message: technicalInfo),
            SksMenuHeader(
              dateTimeOfLastUpdate: sksMenuData.lastUpdate.toIso8601String(),
              isMenuOnline: sksMenuData.isMenuOnline,
            ),
            Padding(
              padding: const EdgeInsets.all(HomeViewConfig.paddingMedium),
              child: SksMenuSection(sksMenuData.meals),
            ),
            TextAndUrl(
              SksMenuConfig.sksDataSource,
              "${context.localize.data_come_from_website}: ",
            ),
            const SizedBox(
              height: ScienceClubsViewConfig.mediumPadding,
            ),
          ],
        ),
      ),
    );
  }
}

class _SKSMenuUnavailableAnimation extends HookWidget {
  const _SKSMenuUnavailableAnimation({this.onShowLastMenuTap});

  final VoidCallback? onShowLastMenuTap;

  @override
  Widget build(BuildContext context) {
    final isAnimationCompleted = useState(false);
    final animationSize = min(
          MediaQuery.sizeOf(context).width,
          MediaQuery.sizeOf(context).height,
        ) *
        0.6;

    final animationTopOffset = -0.2;

    return HorizontalSymmetricSafeAreaScaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: DetailViewAppBar(
        actions: const [
          SksUserDataButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, box) {
          return SizedBox(
            height: box.maxHeight,
            width: box.maxWidth,
            child: Align(
              alignment: const Alignment(0, -0.2),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Transform.translate(offset: Offset(0, animationTopOffset * animationSize),
                      child: SizedBox.square(
                        dimension: animationSize,
                        child: Lottie.asset(
                          Assets.animations.sksClosed,
                          fit: BoxFit.cover,
                          repeat: false,
                          frameRate:
                              const FrameRate(LottieAnimationConfig.frameRate),
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
                    ),
                    Opacity(
                      opacity: isAnimationCompleted.value ? 1 : 0,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          animationSize * (-0.1 + animationTopOffset), // the animation has some extra space at the bottom
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
                            if (onShowLastMenuTap != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: MyTextButton(
                                  actionTitle:
                                      context.localize.sks_show_last_menu,
                                  onClick: onShowLastMenuTap,
                                  showBorder: true,
                                  color: context.colorTheme.blueAzure,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
