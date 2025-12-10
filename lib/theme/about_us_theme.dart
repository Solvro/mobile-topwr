import "typography.dart";

class AboutUsHeadline extends BoldBodyTextStyle {
  const AboutUsHeadline({super.color}) : super(fontSize: 19);
}

class AboutUsBody extends BodyTextStyle {
  const AboutUsBody({super.color}) : super(fontSize: 14);
}

class AboutUsHeadlineSmaller extends BoldBodyTextStyle {
  const AboutUsHeadlineSmaller({super.color}) : super(fontSize: 14);
}

class AboutUsBodySmaller extends BodyTextStyle {
  const AboutUsBodySmaller({super.color}) : super(fontSize: 12);
}

// AboutUsTheme styles are now integrated into AppTheme textTheme
// Access them via context.aboutUsTheme extension in app_theme.dart
