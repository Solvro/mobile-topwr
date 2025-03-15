import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/science_club/science_clubs_view/widgets/strategic_badge.dart";
import "../features/science_club/science_clubs_view/widgets/verified_badge.dart";
import "../services/translations_service/repository/translations_repository.dart";

class DualTextSpan extends TextSpan {
  DualTextSpan(
    String title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    double spacing, {
    bool showBadge = false,
    bool showStrategicBadge = false,
  }) : super(
         children: [
           TextSpan(
             text: title,
             style: titleStyle,
             children: [if (showBadge) const VerifiedBadge(), if (showStrategicBadge) const StrategicBadge()],
           ),
           if (subtitle != null)
             TextSpan(
               text: "\n\n", // padding/spacing workaround
               style: TextStyle(fontSize: spacing, height: 1),
             ),
           if (subtitle != null) TextSpan(text: subtitle, style: subtitleStyle),
         ],
       );
}

class DualTextMaxLinesWithTranslation extends ConsumerWidget {
  const DualTextMaxLinesWithTranslation({
    required this.title,
    required this.maxTotalLines,
    this.translate = true,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.spacing = 0,
    this.showVerifiedBadge = false,
    this.showStrategicBadge = false,
    super.key,
  });

  final bool translate;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final int maxTotalLines;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!translate) return _buildText(title, subtitle);

    final translatedTitle = ref.watch(translationsRepositoryProvider(title));
    final translatedSubtitle = subtitle != null ? ref.watch(translationsRepositoryProvider(subtitle!)) : null;

    if (translatedTitle is AsyncLoading || translatedSubtitle is AsyncLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (translatedTitle is AsyncError || translatedSubtitle is AsyncError) {
      return _buildText(title, subtitle);
    }

    return _buildText(translatedTitle.value ?? title, translatedSubtitle?.value ?? subtitle);
  }

  Widget _buildText(String title, String? subtitle) => RichText(
    maxLines: maxTotalLines,
    overflow: TextOverflow.ellipsis,
    text: DualTextSpan(
      title,
      titleStyle,
      subtitle,
      subtitleStyle,
      spacing,
      showBadge: showVerifiedBadge,
      showStrategicBadge: showStrategicBadge,
    ),
  );
}
