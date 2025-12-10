import "typography.dart";

class GreetingTextStyle extends BodyTextStyle {
  const GreetingTextStyle({super.color}) : super(fontSize: 20);
}

class GreetingBoldTextStyle extends BoldBodyTextStyle {
  const GreetingBoldTextStyle({super.color}) : super(fontSize: 20);
}

// GreetingTheme styles are now integrated into AppTheme textTheme
// Access them via context.greetingTheme extension in app_theme.dart
