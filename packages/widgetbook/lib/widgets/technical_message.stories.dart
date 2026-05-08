import "package:flutter/material.dart";
import "package:topwr/widgets/technical_message.dart";
import "package:widgetbook/widgetbook.dart";

part "technical_message.stories.g.dart";

class TechnicalMessageStoryKnobs {
  final String message;
  final String? title;
  final Color? titleColor;
  final AlertType alertType;
  final Icon? icon;
  final Color? backgoundColor;
  final Color? textColor;
  final bool translate;
  final EdgeInsets? padding;
  TechnicalMessageStoryKnobs({
    required this.message,
    this.title,
    this.titleColor,
    required this.alertType,
    this.icon,
    this.backgoundColor,
    this.textColor,
    required this.translate,
    this.padding,
  });
}

const meta = MetaWithArgs<TechnicalMessage, TechnicalMessageStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => TechnicalMessage(
    message: args.message,
    title: args.title,
    titleColor: args.titleColor,
    alertType: args.alertType,
    icon: args.icon,
    onTap: () {},
    backgoundColor: args.backgoundColor,
    textColor: args.textColor,
    translate: args.translate,
    padding: args.padding,
  ),
);

final $default = TechnicalMessageStory(
  args: TechnicalMessageStoryKnobsArgs.fixed(
    message: "Something went wrong while loading this section.",
    title: "Technical message",
    titleColor: Colors.white,
    backgoundColor: const Color(0xFFB00020),
    textColor: Colors.white,
  ),
);
