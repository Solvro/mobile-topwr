import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_expansion_tile.dart";
import "../../../widgets/my_html_widget.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";

class FaqExpansionTile extends ConsumerWidget {
  const FaqExpansionTile({super.key, required this.title, required this.description, this.initiallyExpanded = false});

  final String title;
  final String description;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GuideDetailViewConfig.paddingMedium),
      child: MyExpansionTile(
        title: title,
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: ({bool? expanded}) {
          if (expanded != null) {
            if (expanded) {
              unawaited(ref.trackEvent(UmamiEvents.openFAQQuestion, value: title));
            } else {
              unawaited(ref.trackEvent(UmamiEvents.closeFAQQuestion, value: title));
            }
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: GuideDetailViewConfig.paddingSmall),
            child: ListTile(title: MyHtmlWidget(description, textStyle: context.textTheme.body.copyWith(fontSize: 14))),
          ),
        ],
      ),
    );
  }
}
