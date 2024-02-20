import 'package:flutter/material.dart';
import '../features/home_view/widgets/my_text_button.dart';
import '../theme/app_theme.dart';

class SubsectionHeader extends StatelessWidget {
  const SubsectionHeader(
      {super.key, required this.title, this.actionTitle, this.onClick});

  final String title;
  final String? actionTitle;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.headline),
            actionTitle != null
                ? MyTextButton(onClick: onClick, actionTitle: actionTitle!)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}


