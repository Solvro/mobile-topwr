import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/repositories/translations_repository.dart";

extension RecursivelyTranslateTextSpanX on InlineSpan {
  InlineSpan recursivelyTranslate(BuildContext context, WidgetRef ref) {
    final span = this;

    if (span is TextSpan) {
      final translation = ref.watch(translationsRepositoryProvider(span.text ?? ""));
      return TextSpan(
        text: switch (translation) {
          AsyncData(:final String value) => value,
          _ => span.text,
        },
        style: span.style,
        locale: span.locale,
        mouseCursor: span.mouseCursor,
        semanticsLabel: span.semanticsLabel,
        onEnter: span.onEnter,
        onExit: span.onExit,
        recognizer: span.recognizer,
        spellOut: span.spellOut,
        children:
            span.children?.map((child) {
              return child.recursivelyTranslate(context, ref);
            }).toList(),
      );
    }
    return span;
  }
}

class RichTextWithTranslation extends ConsumerWidget {
  final InlineSpan text;
  final bool translate;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const RichTextWithTranslation({
    required this.text,
    this.translate = true,
    super.key,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!translate) {
      return RichText(
        text: text,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );
    }

    return RichText(
      text: text.recursivelyTranslate(context, ref),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
