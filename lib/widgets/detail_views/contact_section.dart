import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/gestures.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../theme/app_theme.dart";
import "../../utils/determine_contact_icon.dart";
import "../../utils/launch_url_util.dart";
import "contact_icon_widget.dart";

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.list, required this.title});

  final IList<ContactIconsModel> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    final sorted = list.sort((a, b) => a.order.compareTo(b.order));
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
      color: context.colorTheme.greyLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textTheme.headline),
          const SizedBox(height: 16),
          for (final item in sorted)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ContactIcon(
                url: item.url ?? "",
                text: item.text ?? "",
                icon: item.icon,
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactIcon extends ConsumerWidget {
  const _ContactIcon({
    required this.url,
    required this.icon,
    required this.text,
  });

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
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: text,
              style: context.textTheme.bodyOrange.copyWith(
                decoration: url.isNotEmpty
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async => ref.launch(url),
            ),
          ),
        ),
      ],
    );
  }
}
