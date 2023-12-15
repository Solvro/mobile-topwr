import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:topwr/theme/app_theme.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppLocalizations.of(context)!.home_screen_greeting,
            style: context.textTheme.headline
                .copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
        Text('${mapAcademicScheduleDay(context, DateTime.now())}!',
            style: context.textTheme.headline.copyWith(fontSize: 20)),
      ],
    );
  }

  String mapAcademicScheduleDay(BuildContext context, DateTime date) {
    return (() {
      final isEven = date.day.isEven;
      switch (date.weekday) {
        case DateTime.sunday:
          return isEven
              ? "${AppLocalizations.of(context)?.even_f} ${AppLocalizations.of(context)?.sunday}"
              : "${AppLocalizations.of(context)?.odd_f} ${AppLocalizations.of(context)?.sunday}";
        case DateTime.monday:
          return isEven
              ? "${AppLocalizations.of(context)?.even} ${AppLocalizations.of(context)?.monday}"
              : "${AppLocalizations.of(context)?.odd} ${AppLocalizations.of(context)?.monday}";
        case DateTime.tuesday:
          return isEven
              ? "${AppLocalizations.of(context)?.even} ${AppLocalizations.of(context)?.tuesday}"
              : "${AppLocalizations.of(context)?.odd} ${AppLocalizations.of(context)?.tuesday}";
        case DateTime.wednesday:
          return isEven
              ? "${AppLocalizations.of(context)?.even_f} ${AppLocalizations.of(context)?.wednesday}"
              : "${AppLocalizations.of(context)?.odd_f} ${AppLocalizations.of(context)?.wednesday}";
        case DateTime.thursday:
          return isEven
              ? "${AppLocalizations.of(context)?.even} ${AppLocalizations.of(context)?.thursday}"
              : "${AppLocalizations.of(context)?.odd} ${AppLocalizations.of(context)?.thursday}";
        case DateTime.friday:
          return isEven
              ? "${AppLocalizations.of(context)?.even} ${AppLocalizations.of(context)?.friday}"
              : "${AppLocalizations.of(context)?.odd} ${AppLocalizations.of(context)?.friday}";
        case DateTime.saturday:
          return isEven
              ? "${AppLocalizations.of(context)?.even_f} ${AppLocalizations.of(context)?.saturday}"
              : "${AppLocalizations.of(context)?.odd_f} ${AppLocalizations.of(context)?.saturday}";
        default:
          return AppLocalizations.of(context)!.unknown_day;
      }
    })();
  }
}
