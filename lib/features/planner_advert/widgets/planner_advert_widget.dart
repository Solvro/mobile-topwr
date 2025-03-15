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
import "../repository/planner_advert_repository.dart";

class PlannerAdvertBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(plannerAdvertContentRepositoryProvider);
    return switch (state) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final PlannerAdvertContent value) => _PlannerAdvertBanner(value),
      _ => const HorizontalRectangularSectionLoading(),
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
            title: data.title,
            message: data.description,
            alertType: AlertType.info,
            icon: data.url != null ? Icon(Icons.open_in_new_rounded, color: context.colorTheme.whiteSoap) : null,
            onTap: data.url != null ? () async => unawaited(ref.launch(data.url!)) : null,
            backgoundColor: data.backgroundColor != null ? HexColor(data.backgroundColor!) : null,
            textColor: data.textColor != null ? HexColor(data.textColor!) : null,
            translate: true,
          ),
        );
  }
}
