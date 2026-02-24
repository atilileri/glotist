import 'package:flutter/material.dart';

/// Extension on [BuildContext] to simplify access to centralized theming.
///
/// This enforces usage of `context.colorScheme` and `context.textTheme`
/// rather than hardcoding colors and text styles inside widgets, fully
/// supporting light/dark mode transitions transparently.
extension ThemeExtension on BuildContext {
  /// The [ColorScheme] of the current theme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// The [TextTheme] of the current theme.
  TextTheme get textTheme => Theme.of(this).textTheme;
}
