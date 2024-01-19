import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(this.error, {super.key});
  final Object? error;
  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
    return Center(
      child: Text(
        error.toString(),
      ),
    );
  }
}
