import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../services/translations_service/widgets/rich_text_with_translation.dart";
import "../../services/translations_service/widgets/text_with_translation.dart";
import "../../theme/app_theme.dart";
import "../../utils/determine_contact_icon.dart";
import "../../utils/launch_url_util.dart";
import "contact_icon_widget.dart";

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.list, this.title, this.topPadding = 24, this.bottomSpace});

  final IList<ContactIconsModel> list;
  final String? title;
  final double topPadding;
  final IList<Widget>?
  bottomSpace; // widgets to be additionally attached below the list, but stil one the same background

  @override
  Widget build(BuildContext context) {
    final sorted = list.sort((a, b) => a.order.compareTo(b.order));
    return Container(
      padding: EdgeInsets.only(top: topPadding, left: 24, right: 24, bottom: 8),
      color: context.colorTheme.greyLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            TextWithTranslation(title!, style: context.textTheme.headline),
            const SizedBox(height: 16),
          ],
          for (final item in sorted)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ContactIcon(url: item.url ?? "", text: item.text ?? "", icon: item.icon),
            ),
          if (bottomSpace != null) ...bottomSpace!,
        ],
      ),
    );
  }
}

class _ContactIcon extends ConsumerWidget {
  const _ContactIcon({required this.url, required this.icon, required this.text});

  final String url;
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ContactIconWidget(icon: icon),
        const SizedBox(width: 16),
        Expanded(
          child: RichTextWithTranslation(
            text: TextSpan(
              text: text,
              style: context.textTheme.bodyOrange.copyWith(
                color: url.isNotEmpty ? null : Colors.black,
                decoration: url.isNotEmpty ? TextDecoration.underline : TextDecoration.none,
              ),
              recognizer: TapGestureRecognizer()..onTap = () async => ref.launch(url),
            ),
          ),
        ),
      ],
    );
  }
}
