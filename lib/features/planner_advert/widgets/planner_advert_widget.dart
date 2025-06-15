import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../theme/hex_color.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/loading_widgets/simple_previews/horizontal_rectangular_section_loading.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/technical_message.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";
import "../repository/planner_advert_repository.dart";

class PlannerAdvertBanner extends ConsumerWidget {
  const PlannerAdvertBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(plannerAdvertContentRepositoryProvider);
    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final PlannerAdvertContent value) => _PlannerAdvertBanner(value),
      _ => const Padding(
        padding: EdgeInsets.only(top: HomeViewConfig.paddingMedium),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingMedium),
          child: HorizontalRectangularSectionLoading(),
        ),
      ),
    };
  }
}

class _PlannerAdvertBanner extends ConsumerWidget {
  const _PlannerAdvertBanner(this.data);

  final PlannerAdvertContent data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return !data.isEnabled
        ? const SizedBox.shrink()
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingSmall),
          child: TechnicalMessage(
            padding: const EdgeInsets.all(HomeViewConfig.paddingMedium).copyWith(bottom: 0),
            title: data.title,
            titleColor: data.titleColor != null ? HexColor(data.titleColor!) : null,
            message: data.description,
            alertType: AlertType.info,
            icon: data.url != null ? Icon(Icons.open_in_new_rounded, color: context.colorTheme.whiteSoap) : null,
            onTap:
                data.url != null
                    ? () async {
                      unawaited(ref.trackEvent(UmamiEvents.goToBannerExternalLink));
                      unawaited(ref.launch(data.url!));
                    }
                    : null,
            backgoundColor: data.backgroundColor != null ? HexColor(data.backgroundColor!) : null,
            textColor: data.textColor != null ? HexColor(data.textColor!) : null,
            translate: true,
          ),
        );
  }
}
