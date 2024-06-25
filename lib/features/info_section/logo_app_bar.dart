import 'package:flutter/material.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const LogoAppBar(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Przewodnik',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
