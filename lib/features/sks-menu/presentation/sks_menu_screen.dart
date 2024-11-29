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

    return asyncSksMenuData.when(
      data: (sksMenuData) => _SksMenuView(
        asyncSksMenuData.value ??
            SksMenuResponse(
              isMenuOnline: false,
              lastUpdate: DateTime.now(),
              meals: List.empty(),
            ),
        appBarPopTitle,
      ),
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
  const _SksMenuView(this.sksMenuData, this.appBarPopTitle);

  final SksMenuResponse sksMenuData;
  final String? appBarPopTitle;
  @override
  Widget build(BuildContext context) {
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
  });

  final Object? error;
  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
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
        ],
      ),
    );
  }
}
