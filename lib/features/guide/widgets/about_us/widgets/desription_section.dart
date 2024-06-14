import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../../../config/ui_config.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../utils/launch_url_util.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
          color: context.colorTheme.greyLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AboutUsConfig.defaultPadding),
          child: HtmlWidget(
            text,
            textStyle: context.aboutUsTheme.body,
            customStylesBuilder: (element) {
              if (element.localName == 'a') {
                return {
                  'color':
                      '#${context.colorTheme.orangePomegranade.value.toRadixString(16).padLeft(8, '0').substring(2)}',
                  'text-decoration': 'none',
                };
              }
              return null;
            },
            //todo
            onTapUrl: (url) async {
              return LaunchUrlUtil.launch(url);
            },
          ),
        ),
      ),
    );
  }
}
