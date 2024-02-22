import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class DetailsScreenAppBar extends StatelessWidget {
  const DetailsScreenAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        automaticallyImplyLeading: false,
        title: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Text(
              '< $title',
              style: context.textTheme.boldBodyOrange,
            )),
    );
  }
}
