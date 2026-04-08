# Widgetbook for ToPWR

This package is a dedicated `Widgetbook` workspace for developing and reviewing UI components used in the ToPWR mobile app.

## Getting started

From the `widgetbook` directory:

```bash
flutter pub get
```

## Run Widgetbook

```bash
flutter run -t lib/main.dart
```

## Generate stories and component registry

Whenever you add or modify `*.stories.dart` files, regenerate Widgetbook output:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Useful files

- `lib/main.dart` - app entry point for Widgetbook
- `lib/widgetbook_config.dart` - Widgetbook configuration
- `lib/components.g.dart` - generated components registry
