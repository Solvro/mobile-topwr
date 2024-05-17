import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/launch_url_util.dart';
import '../../../widgets/my_icon.dart';
import '../models/contact_section_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.list});

  final List<ContactSectionData> list;

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
                iconPath: item.iconUrl,
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
    required this.iconPath,
    required this.text,
  });

  final String url;
  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyIcon(path: iconPath),
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
