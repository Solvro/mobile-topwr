import 'package:flutter/material.dart';
import 'package:topwr/config.dart';
import 'package:topwr/theme/app_theme.dart';
import 'package:topwr/theme/hex_color.dart';

import '../../../theme/colors.dart';

class ExamSessionCountdown extends StatefulWidget {
  final DateTime examDate;
  const ExamSessionCountdown({super.key, required this.examDate});

  @override
  State<ExamSessionCountdown> createState() => _ExamSessionCountdownState();
}

class _ExamSessionCountdownState extends State<ExamSessionCountdown> {
  final DateTime today = DateTime.now();

  String? timeDiff;

  @override
  void initState() {
    timeDiff =
        widget.examDate.difference(today).inDays.toString().padLeft(3, '0');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: 69,
        decoration: BoxDecoration(
          gradient: ColorsConsts.toPwrGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++) IntBox(int: timeDiff![i]),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ExamSessionCountdownConfig.daysString,
                  style: context.textTheme.headlineWhite,
                ),
                Text(
                  ExamSessionCountdownConfig.toStartSessionString,
                  style: context.textTheme.bodyWhite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IntBox extends StatelessWidget {
  final String int;
  const IntBox({
    super.key,
    required this.int,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 28,
      height: 37,
      decoration: BoxDecoration(
        color: context.colorTheme.whiteSoap,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: HexColor('#C62D2E66').withOpacity(.4),
            offset: const Offset(-1, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          int,
          style: context.textTheme.headline,
        ),
      ),
    );
  }
}
