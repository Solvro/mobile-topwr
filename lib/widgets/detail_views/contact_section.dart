import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../utils/determine_contact_icon.dart";
import "../../utils/launch_url_util.dart";
import "contact_icon_widget.dart";

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.list,
    this.title,
    this.topPadding = 24,
    this.shouldBeAccessible = false,
    this.bottomSpace,
  });

  final IList<ContactIconsModel> list;
  final String? title;
  final double topPadding;
  final bool shouldBeAccessible;
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
          if (title != null) ...[Text(title!, style: context.textTheme.headline), const SizedBox(height: 16)],
          for (final item in sorted)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ContactIcon(
                url: item.url,
                text: item.text ?? "",
                icon: item.icon,
                shouldBeAccessible: shouldBeAccessible,
              ),
            ),
          if (bottomSpace != null) ...bottomSpace!,
        ],
      ),
    );
  }
}

class _ContactIcon extends ConsumerWidget {
  const _ContactIcon({this.url, required this.icon, required this.text, required this.shouldBeAccessible});

  final String? url;
  final String text;
  final String icon;
  final bool shouldBeAccessible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: text,
      button: url?.isNotEmpty ?? false,
      container: true,
      child: ExcludeSemantics(
        child: Row(
          children: [
            ContactIconWidget(icon: icon),
            const SizedBox(width: 16),
            Expanded(
              child: RichText(
                textScaler: context.textScaler,
                text: TextSpan(
                  text: text,
                  style: context.textTheme.bodyOrange.copyWith(
                    color: url?.isNotEmpty ?? false ? null : Colors.black,
                    decoration: url?.isNotEmpty ?? false ? TextDecoration.underline : TextDecoration.none,
                    height: shouldBeAccessible
                        ? DigitalGuideConfig.accessibleLineHeight
                        : context.textTheme.bodyOrange.height,
                  ),
                  recognizer: url != null ? (TapGestureRecognizer()..onTap = () => ref.launch(url!)) : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
