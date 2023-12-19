import '../config.dart';

enum Digit { first, second, third }

extension DaysLeftStringConverter on DateTime {
  String get daysLeftFromNowString => difference(DateTime.now())
      .inDays
      .toString()
      .padLeft(Digit.values.length, ExamSessionCountdownConfig.defaultDigit);
}

extension GetDigitExtension on String {
  String getDigit(Digit digit) => length >= Digit.values.length
      ? this[digit.index]
      : ExamSessionCountdownConfig.defaultDigit;
}