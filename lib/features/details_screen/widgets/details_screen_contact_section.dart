import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api_base/schema.graphql.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_icon.dart';

class ContactSectionData {
  String? iconUrl;
  String? text;
  String? url;
  Enum$ENUM_COMPONENTINFOINFO_TYPE? type;

  ContactSectionData({
    required this.iconUrl,
    required this.text,
    required this.url,
    required this.type,
  }) {
    if (url != null) {
      _invalidateUrl();
    }
  }

  void _invalidateUrl() {
    String t;
    switch (type) {
      case Enum$ENUM_COMPONENTINFOINFO_TYPE.Email:
        t = 'mailto:';
        break;
      case Enum$ENUM_COMPONENTINFOINFO_TYPE.PhoneNumber:
        t = 'tel:';
        break;
      case Enum$ENUM_COMPONENTINFOINFO_TYPE.Website:
        t = 'https://';
        break;
      default:
        t = '';
        break;
    }
    if (!(url?.startsWith(t) ?? false)) {
      Logger().w("Following url: $url not properly formatted.");
      url = t + url!;
    }
  }
}

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
          Text(context.localize?.contact ?? '',
              style: context.textTheme.headline),
          const SizedBox(height: 16),
          ...list
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _IconWithUrl(
                      url: Uri.parse(item.url ?? ''),
                      text: item.text ?? '',
                      iconPath: item.iconUrl ?? '',
                    ),
                  ))
              .toList(),
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

  final Uri url;
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
                  ..onTap = () => launchUrl(url),
              )),
        )
      ],
    );
  }
}
