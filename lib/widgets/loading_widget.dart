import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.colorTheme.orangePomegranade,
      ),
    );
  }
}