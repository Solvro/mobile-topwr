import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/determine_icon.dart';
import '../../../utils/launch_url_util.dart';
import '../../../widgets/my_icon.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.list});

  final List<UrlIconsModel> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
      color: context.colorTheme.greyLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize.contact, style: context.textTheme.headline),
          const SizedBox(height: 16),
          for (final item in list)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _IconWithUrl(
                url: item.url ?? '',
                text: item.text ?? '',
                icon: item.icon,
              ),
            )
        ],
      ),
    );
  }
}

class _IconWithUrl extends StatelessWidget {
  const _IconWithUrl({
    required this.url,
    required this.icon,
    required this.text,
  });

  final String url;
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyIcon(icon: icon),
        const SizedBox(width: 16),
        Expanded(
          child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: text,
                style: context.textTheme.bodyOrange
                    .copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => LaunchUrlUtil.launch(url),
              )),
        )
      ],
    );
  }
}
