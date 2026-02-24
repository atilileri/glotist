import 'package:flutter/widgets.dart';

/// Centralized layout breakpoints and responsive extensions.
///
/// Follows standard adaptive layout conventions (e.g., Material 3).
class AppBreakpoints {
  /// Mobile (Compact): 0 - 599
  static const double mobile = 600;

  /// Tablet (Medium): 600 - 839
  static const double tablet = 840;

  /// Desktop (Expanded): 840+
}

/// Extension on [BoxConstraints] to simplify component-level responsive checks.
extension ResponsiveConstraints on BoxConstraints {
  /// Whether the available width is in the compact range (mobile).
  bool get isCompact => maxWidth < AppBreakpoints.mobile;

  /// Whether the available width is in the medium range (tablet).
  bool get isMedium =>
      maxWidth >= AppBreakpoints.mobile && maxWidth < AppBreakpoints.tablet;

  /// Whether the available width is in the expanded range (desktop).
  bool get isExpanded => maxWidth >= AppBreakpoints.tablet;
}

/// Extension on [BuildContext] to simplify screen-level responsive checks.
extension ResponsiveContext on BuildContext {
  /// Whether the screen width is in the compact range (mobile).
  bool get isCompact => MediaQuery.sizeOf(this).width < AppBreakpoints.mobile;

  /// Whether the screen width is in the medium range (tablet).
  bool get isMedium =>
      MediaQuery.sizeOf(this).width >= AppBreakpoints.mobile &&
      MediaQuery.sizeOf(this).width < AppBreakpoints.tablet;

  /// Whether the screen width is in the expanded range (desktop).
  bool get isExpanded => MediaQuery.sizeOf(this).width >= AppBreakpoints.tablet;
}

/// Extension on [double] to simplify width-based responsive checks.
extension ResponsiveDouble on double {
  /// Whether the width is in the compact range.
  bool get isCompactWidth => this < AppBreakpoints.mobile;

  /// Whether the width is in the medium range.
  bool get isMediumWidth =>
      this >= AppBreakpoints.mobile && this < AppBreakpoints.tablet;

  /// Whether the width is in the expanded range.
  bool get isExpandedWidth => this >= AppBreakpoints.tablet;
}
