import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MyIcon extends StatelessWidget {
  const MyIcon({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(6),
      elevation: 2,
      child: ClipOval(
        child: Container(
            padding: const EdgeInsets.all(8),
            color: context.colorTheme.whiteSoap,
            child: SizedBox(width: 20, height: 20, child: Image.asset(path)))),
      );
  }
}
